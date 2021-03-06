// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Add a blind-up / blind-down option to field relations */
document.observe('dom:loaded', function() {
  if ($$('.fieldRelations').length > 0)
  {
    $$('.fieldRelations').each(function(fieldRelation) {
      var link = fieldRelation.down('a') ;
      fieldRelation.down('ul').hide() ;
      link.observe('click', function(event){
        Effect.toggle(fieldRelation.down('ul'), 'blind', {
          afterFinish: function() {
            if (link.innerHTML == 'more')
            {
              link.innerHTML = 'less' ;
            } else {
              link.innerHTML = 'more' ;
            }
          }  
        }) ;
        event.stop() ;
      }) ;
    }) ;
  }

  // Create color observers
  $$(".colorPicker").each(function(color_picker) {
      create_color_picker(color_picker) ;
  }) ;
}) ;

function new_color_picker(top_div) {
  create_color_picker(top_div.down(".colorPicker")) ;
}

function create_color_picker(color_picker_div) {
    new Form.Element.Observer(
      color_picker_div.down('input'),
      0.2,
      function(el, value) {
        el.next(".relationSquare").setStyle("border-color: " + value) ;
    }) ;
}

/* Used for pattern system edition */
function remove_fields(link) {
  // Set the hidden field to true
  var surrounding_div = $(link).up("div") ;
  surrounding_div.childElements().find(function(el) {
    return el.type == 'hidden' && el.name.include("[_destroy]") ;    
  }).value = true ;
  // Hide the surrounding tag 
  surrounding_div.hide() ; 
}

function add_fields(link, association, content, event_callback) {
  var new_id = new Date().getTime() ;
  var regexp = new RegExp("new_" + association, "g")
  // We make sure we generate a unique id for each set of field
  $(link).insert({
    before: content.replace(regexp, new_id)
  }) ;

  if (event_callback) {
    var new_element = $(link).previous() ;
    event_callback.call(this, new_element) ;
  }

}

// We disable the console when firebug is not loaded
if (!("console" in window) || !("firebug" in console)) {
 var names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"];
 window.console = {};
 for (var i = 0, len = names.length; i < len; ++i) {
 window.console[names[i]] = function(){};
 }
}


