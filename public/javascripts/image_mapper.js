
/*
 * TODO Manage image deletion (i.e. replace the image by
 * our custom form).
 * TODO Manage relations within the map forms
 */
var AgapImageManager = {
  pattern: undefined,
  pattern_system: undefined,
  token_value: undefined,
  active_map: false,
  is_moving_map: false,
  is_resizing: false,
  current_map: undefined,
  current_control: undefined,
  mouse_pos: undefined,

  /**
   * Sets a number of general purpose variables, such as 
   * the location of the current page, the authenticity
   * token (from the Rails form).
   */
  get_page_data : function() {
    var loc = location.href ;
    var partial_loc_array = loc.split('/pattern_systems/', 2)[1].split('/') ;
    AgapImageManager.pattern_system = partial_loc_array[0] ;
    AgapImageManager.pattern = partial_loc_array[2] ;
    
    // We get the authenticity token from the top form
    if ($('edit_pattern_' + AgapImageManager.pattern)) {
      AgapImageManager.token_value = $('edit_pattern_' + AgapImageManager.pattern).down('input[name=authenticity_token]').value ;
    } else if ($('new_pattern')) {
      AgapImageManager.token_value = $('new_pattern').down('input[name=authenticity_token]').value ;
    }
    console.log("Fetched page data") ;
  }, 

  /**
   * Looks for a file input field that corresponds to
   * a mappable image (as defined by AgapLite). It
   * replaces the current field by a some form, which
   * sends an asynchronous request to the server when
   * submitted. It should be used within a file upload
   * and display workflow, and as such should precede 
   * a call to 'install_image_observer' (usually made
   * by the server.
   */
  install_form_observer: function() {
    $$('input[type=file]').each(function(el) {
        var field_id = el.up().previous("input[type=hidden]").value ;
        console.log("Field descriptor id: " + field_id) ;
        // If there is already an image, install the
        // image observer and hide the existing form
        var existing_image = $("mappable_image_image_" + field_id) ;
       
        // If there an image has already been uploaded,
        // install an image observer instead 
        if (existing_image) {
          el.remove() ;
          AgapImageManager.install_image_observer(existing_image) ;
          return ;
        }

        var requestURI = encodeURI("/pattern_systems/" + AgapImageManager.pattern_system + "/patterns/upload_file/" + AgapImageManager.pattern) ;
        console.log("The request will be sent to: \n" + requestURI) ;
        var loading = undefined ;
        
        var form = new Element('form', {
          id: "upload_file_form_" + field_id,
          method: "POST",
          enctype: "multipart/form-data",
          onSubmit: "this.hide(); this.insert({'after': new Element('img', {src: '/images/common_images/loading.gif'})})",
          action: requestURI
        }) ;
        var token = new Element('input', {type: "hidden", name: "authenticity_token", value: AgapImageManager.token_value}) ;
        var input = new Element('input', {type: "file", size: 30, name: "mappable_image[image]"}) ;
        var field_desc_id = new Element('input', {type: "hidden", name:"field_id", value: field_id}) ;
        var submit =  new Element('input', {type: 'submit', value: 'submit', style: "display: none"}) ;
        var iframe = new Element('iframe', {
          id: "upload_iframe_" + field_id,
          name: "upload_iframe_" + field_id,
          style: "width:1px; height:1px; border:0px;",
          src: "about:blank"  
        }) ;
        el.replace(form) ;
        form.insert({'top': input}) ;
        form.insert({'top': field_desc_id}) ;
        form.insert({'top': token}) ;
        form.insert({'bottom': submit}) ;
        form.insert({'after': iframe}) ;
        input.observe('change', function(event) {
          var params =  {mappable_image_file_name: $F(input), mappable_image_field_descriptor_id: field_id} ;
          form.target = "upload_iframe_" + field_id;
          submit.click() ;
          event.stop() ;
       }) ;
       console.log("Installed file field observer") ;
    });
  },

  /**
   * Prepares the mappable image (that was just uploaded
   * or as displayed by an edit action) for adding maps.
   */
  install_image_observer: function(image, image_id) {
    // TODO Add a hidden field pointing to the mappable image id
    if (image_id) {
      // In this case, add a hidden field
      // First, get a known hidden field, that will be
      // cloned then transformed to fit our needs
      var clonedNode = image.up().previous().previous().cloneNode(false) ; // should be the pattern_id field
      clonedNode.id = clonedNode.id.replace(/pattern_id/,"mappable_image_id") ;
      clonedNode.name = clonedNode.name.replace(/pattern_id/,"mappable_image_id") ;
      clonedNode.value = image_id ;
      image.up().insert({'before': clonedNode});
    }
    // Add a delete sign on the top right corner of the image

    // First get the position of the image on the layout
    var img_pos = image.cumulativeOffset() ;
    var add_link = new Element('a', {href: "#"}).update("Add a map") ;
    var cancel_link = new Element('a', {href: "#"}).update("Cancel mapping") ;
    var del_img = new Element('img', {
      src: "/images/common_images/delete.png",
      style: "position: relative; float: right; top: " + -22 + "px; left: " + 22 +"px; width: 45px;height: 45px; z-index: 10",
      alt: "delete image"
    }) ;
    var ok_img = new Element('img', {
      src: "/images/common_images/validate.png",
      style: "position: relative; float: right; top: " + -22 + "px; left: " + 22 +"px; width: 45px;height: 45px; z-index: 10",
      alt: "validate map"
    }) ;
    image.insert({'top': del_img}) ;
    image.insert({'top': ok_img}) ;
    ok_img.hide() ;
    image.insert({'after': add_link}) ;
    image.insert({'after': cancel_link}) ;
    cancel_link.hide() ;

    // This line for getting absolute positioning
    // for the dd elements, relatively to the
    // position of the image (which is therefore
    // not statically positioned)
    image.setStyle({position: 'relative'}) ;

    AgapImageManager.update_maps(image) ;

    del_img.observe('click', function(event) {
      alert("delete this image!!") ;    
      // TODO Deleting the image should make the
      // previous form reappear
      event.stop() ;
    }) ;
    add_link.observe('click', function(event) {
      if (!AgapImageManager.active_map) {
        AgapImageManager.create_new_map(image) ;
        add_link.hide() ;
        del_img.hide() ;
        ok_img.show() ;
        cancel_link.show() ;
      }
      event.stop() ;
    }) ;
    
    ok_img.observe('click', function(event) {
      // Map validation should include adding a little
      // cross at the top right corner of each map, which appears
      // on a mouseover for deleting the map
      cancel_link.hide() ;
      add_link.show() ;
      // Remove the opacity blocks and the active map
      // TODO Adopt a cheaper show/hide approach
      $("top_block").remove() ;
      $("left_block").remove() ;
      $("right_block").remove() ;
      $("bottom_block").remove() ;
      AgapImageManager.active_map = false ;
      ok_img.hide() ;
      del_img.show() ;
      Popup.open('pattern_selector') ;

      event.stop() ;
    }) ;

    cancel_link.observe("click", function(event) {
      AgapImageManager.active_map = false ;
      $$(".active_map").first().remove() ; 

      $("top_block").remove() ;
      $("left_block").remove() ;
      $("right_block").remove() ;
      $("bottom_block").remove() ;
      cancel_link.hide() ;
      add_link.show() ;
      ok_img.hide() ;
      del_img.show() ;
      AgapImageManager.update_maps(image) ;
      event.stop() ;    
    }) ;
    // Finally, observe the mouse movements on the image, which
    // might be resizing or move actions
    image.observe("mousemove", function(event) {
      if (AgapImageManager.is_moving_map) {
        var old_p = AgapImageManager.mouse_pos ;
        var new_p = event.pointer() ;
        AgapImageManager.mouse_pos = new_p ;
        var diff = {x : new_p.x - old_p.x, y : new_p.y - old_p.y} ;
        var map = AgapImageManager.current_map ;
        var m_pos = map.positionedOffset() ;
        if ((m_pos.left + map.getWidth() + diff.x < image.getWidth()) &&
          (m_pos.left + diff.x > 0) &&
          m_pos.top + map.getHeight() + diff.y < image.getHeight() &&
          m_pos.top + diff.y > 0
        ) {
          map.setStyle({
            left: m_pos.left + diff.x + "px",
            top : m_pos.top + diff.y + "px"
          }) ;
          var m_dim = {width: parseInt(map.getStyle('width').split("px")[0]), height: parseInt(map.getStyle("height").split("px")[0])} ;
          var i_dim = {width: parseInt(image.getStyle('width').split("px")[0]), height: parseInt(image.getStyle("height").split("px")[0])} ;
          AgapImageManager.update_opacity_block(m_pos, m_dim, i_dim) ;
        }
      } else if (AgapImageManager.is_resizing) {
        var old_p = AgapImageManager.mouse_pos ;
        var new_p = event.pointer() ;
        AgapImageManager.mouse_pos = new_p ;
        var diff = {x : new_p.x - old_p.x, y : new_p.y - old_p.y} ;
        AgapImageManager.resize_map(image, diff) ;
      }
      event.stop() ;
    }) ;
    image.observe("mouseup", function(event) {
      AgapImageManager.is_resizing = false ;
      AgapImageManager.is_moving_map = false ;    
    }) ;
    //image.observe("mouseout", function(event) {
      //AgapImageManager.is_moving_map = false ;    
      //AgapImageManager.is_resizing = false ;
    //}) ;
  },

  /**
   * Updates the position and size of the current
   * active map, based on the mouse movement delta.
   * @argument image : the mappable image on which
   * to execute the resize
   * @argument diff : the mouse movement delta
   */
  resize_map: function(image, diff) {
    var control = AgapImageManager.current_control ;
    var map = control.obj.up("dd") ;
    var m_pos = map.positionedOffset() ;
    var m_dim = {width: parseInt(map.getStyle('width').split("px")[0]), height: parseInt(map.getStyle("height").split("px")[0])} ;
    var i_dim = {width: parseInt(image.getStyle('width').split("px")[0]), height: parseInt(image.getStyle("height").split("px")[0])} ;

    switch(control.type) {
      case "NW" :
        // We move the map to the top and left by diff, while
        // adjusting the width and height
        map.setStyle({
          left: m_pos.left + diff.x + "px",
          top: m_pos.top + diff.y + "px",
          width: m_dim.width - diff.x + "px",
          height: m_dim.height - diff.y + "px"
        }) ;
        break ;

      case "NE" :
        map.setStyle({
          top: m_pos.top + diff.y + "px",
          width: m_dim.width + diff.x + "px",
          height: m_dim.height - diff.y + "px"
        }) ;
        break;

      case "SW" :
        map.setStyle({
          left: m_pos.left + diff.x + "px",
          height: m_dim.height + diff.y + "px",
          width: m_dim.width - diff.x + "px"
        }) ;
        break ;

      case "SE" :
        map.setStyle({
          height: m_dim.height + diff.y + "px",
          width: m_dim.width + diff.x + "px"
        }) ;
        break ;

    } 

    AgapImageManager.update_opacity_block(m_pos, m_dim, i_dim);
    // Update the position of the controls
    $("NE_resize").setStyle({left: m_dim.width - diff.x - 4 + "px"}) ;
    $("SE_resize").setStyle({left: m_dim.width - diff.x - 4 + "px", top: m_dim.height - diff.y - 4 + "px"}) ;
    $("SW_resize").setStyle({top: m_dim.height - diff.y -4 + "px"}) ;
  },

  update_opacity_block : function(map_pos, map_dim, image_dim) {
    $("top_block").setStyle({
      height: map_pos.top +"px"
    }) ;
    $("left_block").setStyle({
      top: map_pos.top + "px",
      width: map_pos.left + "px",
      height: map_dim.height + "px"
    }) ;
    $("right_block").setStyle({
      top: map_pos.top + "px",
      left: map_pos.left + map_dim.width + "px",
      width: image_dim.width - map_dim.width - map_pos.left + "px",
      height: map_dim.height + "px"
    }) ;
    $("bottom_block").setStyle({
      top: map_pos.top + map_dim.height + "px",
      height: image_dim.height - map_pos.top - map_dim.height + "px"
    }) ;

  },

  /**
   * Creates a new active map on the current image, with
   * the corresponding control blocks and semi-transparent
   * dark caches.
   */
  create_new_map: function(image) {
    // We hide inactive maps
    image.childElements().select(function(el){if (el.classNames().include("map")) {el.hide() ;}}) ;

    AgapImageManager.active_map = true ;
    var default_width = 120, default_height = 80 ;
    var pos = {top: (image.getHeight() - default_height) / 2, left: (image.getWidth() - default_width)/2} ;
    var new_dd = new Element('dd', {
      style: "cursor: move; position: absolute; display: block; width: " + default_width + "px; height: " + default_height + "px; left: " + pos.left + "px; top: " + pos.top + "px; border: 1px dashed black; margin: 0; padding: 0"
    }) ;
    new_dd.addClassName("map active_map") ;
    new_dd.insert({'top': AgapImageManager.create_control_block("NW", -4, -4)}) ;
    new_dd.insert({'top': AgapImageManager.create_control_block("SW", default_height - 4, -4)}) ;
    new_dd.insert({'top': AgapImageManager.create_control_block("NE", -4, default_width - 4)}) ;
    new_dd.insert({'top': AgapImageManager.create_control_block("SE", default_height - 4, default_width - 4)}) ;
    image.insert({'top': AgapImageManager.create_opacity_block("top", 0, 0, image.getWidth(), pos.top)}) ;
    image.insert({'top': AgapImageManager.create_opacity_block("left", pos.top, 0, pos.left, default_height)}) ;
    image.insert({'top': AgapImageManager.create_opacity_block("bottom", pos.top + default_height, 0, image.getWidth(), image.getHeight() - default_height - pos.top)}) ;
    image.insert({'top': AgapImageManager.create_opacity_block("right", pos.top, pos.left + default_width, image.getWidth() - pos.left - default_width, default_height)}) ;
    image.insert({'bottom': new_dd}) ;


    // Add on observer for mouse downs on the dd, which
    // might correspond to movement actions
    new_dd.observe("mousedown", function(event) {
      AgapImageManager.is_moving_map = true ;
      AgapImageManager.current_map = new_dd ;
      AgapImageManager.mouse_pos = event.pointer() ;
    }) ;
    new_dd.observe("mouseup", function(event) {
      AgapImageManager.is_moving_map = false ;
      AgapImageManager.current_map = null ;
    }) ;
  },

  /**
   * Creates a control block on the current map, that
   * is, a small square for resizing the map. Specific cursor
   * styles are set up, depending
   * on the <code>resize_type</code> argument
   */
  create_control_block: function(resize_type, top, left) {
    var default_size = 8 ;
    var control = new Element('div', {
      style: "cursor: " + resize_type + "-resize; position: absolute; border: 1px solid black; left: " + left + "px; top: " + top + "px; width: " + default_size + "px; height: " + default_size+ "px;", 
      id: resize_type + "_resize"
    }) ;
    // Install the observers for resizing the map
    control.observe('mousedown', function(event) {
      AgapImageManager.is_resizing = true ;
      AgapImageManager.current_control = {type: resize_type, obj: control} ;
      AgapImageManager.mouse_pos = event.pointer() ;
      event.stop() ;
    }) ;
    control.observe('mouseup', function(event) {
      AgapImageManager.is_resizing = false ;
      AgapImageManager.current_control = undefined ;
      event.stop() ;
    });
    return control ;
  },

  /**
   * Creates a semi-transparent block, used as a cache when
   * setting up the active map's size, position etc.
   */
  create_opacity_block: function(block_type, top, left, width, height) {
    return new Element('div', {
      id: block_type + "_block",
      style: "position: absolute; top: " + top + "px; left: " + left + "px; width: " + width + "px; height: " + height + "px; z-index: 5; background-color: #000; opacity: 0.5"
    }) ;
  },

  /**
   * Gets all the existing map fields for the current image
   * and displays the corresponding maps with a delete icon
   * on the top right corner.
   */
  update_maps: function(image) {
    // Get all the maps from the image
    var maps = image.up().up().childElements().select(function(el){
        return el.classNames().include("map_fields") &&
                  !el.childElements().any(function(a){return a.name.include("blank_map_record")}) &&
                  !el.childElements().any(function(a){return a.name.include("_destroy") && a.value == 1})
        });
    console.log(maps.size()) ;
    maps.each(function(el){
      var x_corner = el.down().value ;
      var y_corner = el.down().next().value ;
      var width = el.down().next().next().value ;
      var height = el.down().next().next().next().value ;
      var map_id = el.id.split("map_fields_")[1] ;
      // We generate an id for the map, if necessary
      if (map_id == undefined) {
        var map_id = new Date().getTime() ;
        el.id = "map_fields_" + map_id ;
      }
      var del_img = new Element('img', {
        src: "/images/common_images/delete.png",
        style: "position: relative; float: right; top: " + -12 + "px; left: " + 12 +"px; width: 25px;height: 25px; z-index: 10",
        alt: "delete image"
    }) ;
      var the_map =  new Element('dd', {
            style: "position: absolute; display: block; width: " + width + "px; height: " + height + "px; left: " + x_corner + "px; top: " + y_corner + "px; border: 1px solid red; margin: 0; padding: 0"
            }) ;
      the_map.addClassName("map") ;
      the_map.insert({'top' : del_img}) ;
      image.insert({'top': the_map}) ;    
      del_img.observe('click', function(event){
         // We get the map which corresponds to this id
        $("map_fields_" + map_id).childElements().last().value = 1 ;
        the_map.remove() ;
      }) ;
    }) ;
  },


  /**
   * Creates a new map form field, filled with the 
   * current active map's attributes, and then
   * removes the active map before updating the
   * list of existing maps.
   */
  validate_map: function(relation_id) {
    var map = $$(".active_map").first() ;
    var m_pos = map.positionedOffset() ;
    var m_dim = {width: parseInt(map.getStyle('width').split("px")[0]), height: parseInt(map.getStyle("height").split("px")[0])} ;

    // Add m_pos and m_dim to the form
    var sub_id = new Date().getTime() ;

    // Get a copy of a blank map_field
    // (i.e a map_field with an input set to
    // 'blank_map_record', then replace this
    // with the sub_id
    var blank_map = $$(".map_fields").select(function(el){
      return el.down("input[type=hidden]").name.include("blank_map_record")
    }).first() ;
    var clone = blank_map.cloneNode(blank_map) ;
    clone.childElements().each(function(el){
      el.name = el.name.replace(/blank_map_record/g, sub_id) ;    
    }) ;
    var x_corner = clone.down()
    x_corner.value = m_pos.left ;
    var y_corner = x_corner.next()
    y_corner.value = m_pos.top ;
    var width = y_corner.next() ;
    width.value = m_dim.width ;
    var height = width.next() ;
    height.value = m_dim.height ;
    var relation = height.next() ;
    relation.value = relation_id ;
    blank_map.insert({'after': clone}) ;
    clone.id = "map_fields_" + sub_id   ;
    console.log(clone) ;
    var image = map.up("dl") ;
    map.remove() ;

    AgapImageManager.update_maps(image) ;
  }
} ;


/*
 * Initialization block
 */
document.observe('dom:loaded', function(){
  AgapImageManager.get_page_data() ;
  AgapImageManager.install_form_observer() ;
}) ;

