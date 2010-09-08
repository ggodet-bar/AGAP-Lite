function AgapSelector(sel, states, transitions, blank_association, association_name) {
  this.selector = sel ;
  this.blank_association = blank_association ;
  this.association_name = association_name ;
  this.state_machine = new StateMachine(states, transitions) ;
  this.state_machine.initialize(this, "init", null) ;
}


AgapSelector.prototype.install_mono_selector = function() {
    this.selector.insert({'after': new Element('div', {'class': 'selectorContainer'})});
    this.selector.options[0].text = 'Please select' ;
    if (this.selector.selectedIndex != 0) {
      this.selected() ;
      this.state_machine.currentState = 'selected' ;
    } else {
      this.state_machine.currentState = 'unselected' ;
    }

    var s_m = this.state_machine ;
    this.selector.observe('change', function(event){
          s_m.next('select') ;
          event.stop() ;
    });
}

AgapSelector.prototype.install_multi_selector = function() {
    this.state_machine.currentState = 'main' ;
    // We replace the existing selector by a dropdown
    this.dropdown = new Element('select') ;
    this.selector.insert({'before' : this.dropdown}) ;

    this.selector.insert({'after' : new Element("div", {'class': 'selectorContainer'})}) ;

    var the_prompt = new Element('option', {value: ""}).update('Please select') ;
    this.dropdown.insert({'top' : the_prompt}) ;
    // We use the same options as the existing multi selector
    for (var i = 0 ; i < this.selector.length ; i++) {
      var is_selected = this.selector.options[i].selected ;
      var option = new Element('option', {value: this.selector.options[i].value, disabled: is_selected}).update(this.selector.options[i].text) ;
      this.dropdown.insert({'bottom': option}) ;
      if (is_selected) {
        // We add selected items following the current state of the selection
        this.selected(i) ;
      }
    }
    this.selector.hide() ; // We need to keep the original selection around for keeping the track of the selections

    // We scan the associationFields div for existing elements
    // this.selector.next(".associationFields").childElements().each(function(element){
    //   alert(element) ;    
    // }) ;

    var drop = this.dropdown ;
    var s_m = this.state_machine ;
    this.dropdown.observe('change', function(event){
       s_m.next('select', drop.selectedIndex) ;
       event.stop() ;
    }) ;
    this.dropdown.selectedIndex = 0 ;
  },

/*
 *  This function is called one item at a time. The input is the div of the
 *  option, when relevant
 */
AgapSelector.prototype.update = function(div) {
 // If the selector index is not 0, then the user has selected
 // an option to remove
 if (this.dropdown.selectedIndex != 0) {
    this.selected(this.dropdown.selectedIndex - 1) ;
 } else {
    this.unselected(div) ;
 } 
}

AgapSelector.prototype.selected = function(force_index_nb) {
    var index = force_index_nb >= 0 ? force_index_nb : this.selector.selectedIndex ;
    var div = new Element('div').update(this.selector.options[index].text) ;
    var element_value = this.selector.options[index].value ;
    div.addClassName("selector_item") ;
    var a = new Element('a', {href: "#", style: "float: right"}).update('remove') ;
    var hidden = new Element('input', {type: 'hidden', value: index}) ;
    div.insert({'bottom': a}) ;
    div.insert({'bottom': hidden}) ;
    div.identify() ;

    // We get the last item and insert our div just after
    var container = this.selector.next(".selectorContainer")
                                 .insert({"bottom": div}) ;

    if (this.blank_association !== undefined) {
      var new_id = new Date().getTime() ;
      var regexp = new RegExp("new_" + this.association_name, "g") ;


      var association_fields = this.selector.next(".associationFields") ;
      var target_association_field = $$("#" + association_fields.id + " .targetAssociationValue").find(function(element){
         return element.classNames().include('targetAssociationValue') &&
                element.value == element_value ;
      }) ;
      if (target_association_field == null) {
        this.selector.next(".associationFields")
                     .insert(this.blank_association.replace(regexp, new_id)) ;
        $$("#" + association_fields.id + " .targetAssociationValue").last().value = element_value ;
      } else {
        var target_association = target_association_field.up(".singleRelation") ;
        var destroy_field = target_association.childElements().find(function(el){
          return el.name.include("[_destroy]") ;    
        }) ;
        destroy_field.value = false ;
      }
    }
    
    var s_m = this.state_machine ;
    a.observe('click', function(event) {
          s_m.next('unselect', div) ;
          event.stop() ;
    }) ;
    if (force_index_nb >= 0) {
      this.dropdown.options[index + 1].disabled = true ;
      this.selector.options[index].selected = true ;
      this.dropdown.selectedIndex = 0 ;
    } else {
      this.selector.hide() ;
    }
}

AgapSelector.prototype.unselected = function(item) {
    var index = parseInt(item.down('input[type=hidden]').value) ;  
    item.remove() ;
    if (this.dropdown) {
      this.dropdown.options[index + 1].disabled = false ;
      this.selector.options[index].selected = false ;

      var element_value = this.selector.options[index].value ;
     
      var association_fields = this.selector.next(".associationFields") ;
      var target_association_field = $$("#" + association_fields.id + " .targetAssociationValue").find(function(el){
        return el.value == element_value ;    
      }) ;
      var target_association = target_association_field.up(".singleRelation") ;
      
      var destroy_field = target_association.childElements().find(function(el){
        return el.name.include("[_destroy]") ;    
      }) ;

      destroy_field.value = true ;
    } else {
      this.selector.selectedIndex = 0 ;
      this.selector.show() ;
    }
}

AgapSelector.mono_states = [
        {
          name: 'init',
          localFunction: AgapSelector.prototype.install_mono_selector
        },
        {
          name: 'selected',
          localFunction: AgapSelector.prototype.selected
        },
        {
          name: 'unselected',
          localFunction: AgapSelector.prototype.unselected
        }
      ] ;

AgapSelector.mono_transitions = [
        {
          eventName: 'select',
          initialState: 'unselected',
          nextState: 'selected'
        },
        {
          eventName: 'unselect',
          initialState: 'selected',
          nextState: 'unselected'
        }
      ] ;

AgapSelector.multi_states = [
        {
          name: 'init',
          localFunction: AgapSelector.prototype.install_multi_selector
        },
        {
          name: 'main',
          localFunction: AgapSelector.prototype.update
        }
      ] ;

AgapSelector.multi_transitions = [
        {
          eventName: 'select',
          initialState: 'main',
          nextState: 'main'
        },
        {
          eventName: 'unselect',
          initialState: 'main',
          nextState: 'main'
        }
      ] ;

