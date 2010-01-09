function manage_parameters(enable_text, disable_text) {
  if (Cookie.get('noob_mode') == null) {
    Cookie.set('noob_mode', 'true') ;
  }
 if (Cookie.get('noob_mode') == 'true') {
   console.log("entering noob mode") ;
   $('params_caution_text').innerHTML = disable_text ;
   $('param_front_button').setStyle({left: '52px'});
   Droppables.add("off_position", {
      onDrop : function(draggable){
         $('param_front_button').setStyle({left: '186px'}) ;
         Effect.Fade('params') ;
         Droppables.remove('off_position') ;
         Cookie.set('noob_mode', 'false') ;
         for (var i = 0, element ; element = $$('.helper_info')[i]; i++) {
             element.hide() ;
         }
         for (var i = 0, element ; element = $$('.question_mark')[i]; i++) {
             element.hide() ;
         }
      }
   });
  } else {
   console.log("entering expert mode") ;
   $('params_caution_text').innerHTML = enable_text ;
   $('param_front_button').setStyle({left: '186px'});
   Droppables.add("on_position", {
      onDrop : function(draggable){
         $('param_front_button').setStyle({left: '52px'}) ;
         Effect.Fade('params') ;
         Droppables.remove('on_position') ;
         Cookie.set('noob_mode', 'true') ;
         for (var i = 0, element ; element = $$('.question_mark')[i]; i++) {
            element.setStyle({display: 'inline'}) ;
         }
       }
   });
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
  )

}
