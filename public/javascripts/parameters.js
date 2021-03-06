var Parameters = {
	manage_parameters : function(enable_text, disable_text) {
  	if (Cookie.get('noob_mode') == null) {
  	  Cookie.set('noob_mode', 'true') ;
  	}
 	if (Cookie.get('noob_mode') == 'true') {
  	 $('params_caution_text').innerHTML = disable_text ;
  	 $('param_front_button').setStyle({left: '52px'});
  	 Droppables.add("off_position", {
  	    onDrop : function(draggable){
  	       $('param_front_button').setStyle({left: '186px'}) ;
               Parameters.setToOff() ;
  	    }
  	 });
         $("off_position").observe("click", function(ev) {
              new Effect.Move($("param_front_button"), {x: 186, mode: "absolute"});
              Parameters.setToOff() ;
              ev.stop() ;
          }) ;
  	} else {
  	 $('params_caution_text').innerHTML = enable_text ;
  	 $('param_front_button').setStyle({left: '186px'});
  	 Droppables.add("on_position", {
  	    onDrop : function(draggable){
  	       $('param_front_button').setStyle({left: '52px'}) ;
               Parameters.setToOn() ;
  	     }
  	 });
         $("on_position").observe("click", function(ev) {
              new Effect.Move($("param_front_button"), {x: 52, mode: "absolute"});
              Parameters.setToOn() ;
              ev.stop() ;
          }) ;
  	 }
  	   new Draggable('param_front_button', { constraint: 'horizontal', revert: 'failure', snap: function(x, y, draggable_object) {
  	      	if (x > 186) {
  	      	   return [186, y] ;
  	      	}
  	      	if (x < 52) {
  	      	   return [52, y] ;
  	      	}
  	      	return [x, y] ;
  	      }
  	    }
  	) ; 
	},

  setToOff: function() {
   Popup.close('params') ; 
   Droppables.remove('off_position') ;
   Cookie.set('noob_mode', 'false') ;
   $$('.helper_info').each(function(el){el.hide();});
   $$('.question_mark').each(function(el){el.hide();});
   if ($('tabs')) {
      $('tabs').show() ;
   }

  },

  setToOn: function() {
   Popup.close('params') ; 
   Droppables.remove('on_position') ;
   Cookie.set('noob_mode', 'true') ;
   $$('.question_mark').each(function(el){el.show();});

   // Hide the tabs
   if ($('tabs')) {
      $('tabs').hide() ;
   }
  }
}

