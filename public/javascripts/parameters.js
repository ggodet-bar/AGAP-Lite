var Popup = {
	manage_parameters : function(enable_text, disable_text) {
		document.body.style.overflow = "hidden" ;
  	window.onscroll=function() { window.scrollTo(0,0) }
  	var body_size = null ;
  	if (document.documentElement) {
  	 body_size = {	width : document.documentElement.clientWidth,
  	      	  	height : document.documentElement.clientHeight};
  	} else {
  	        body_size = document.body.getDimensions() ;
  	} 
  	var splash = new Element('div', {id : 'splash', style: 'position: fixed; left: -10px; top: -10px; width: ' + body_size.width * 1.1 + 'px;height: ' + body_size.height * 1.1 + 'px; background-color: #000; z-index: 1000' });
  	splash.setOpacity(0.5) ;
  	Element.insert(document.body,{'top' : splash}) ;


///////////////////////////////////////


  	if (Cookie.get('noob_mode') == null) {
  	  Cookie.set('noob_mode', 'true') ;
  	}
 	if (Cookie.get('noob_mode') == 'true') {
  	 $('params_caution_text').innerHTML = disable_text ;
  	 $('param_front_button').setStyle({left: '52px'});
  	 Droppables.add("off_position", {
  	    onDrop : function(draggable){
  	       $('param_front_button').setStyle({left: '186px'}) ;
  	       Popup.close_parameter_window() ; 
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
  	 $('params_caution_text').innerHTML = enable_text ;
  	 $('param_front_button').setStyle({left: '186px'});
  	 Droppables.add("on_position", {
  	    onDrop : function(draggable){
  	       $('param_front_button').setStyle({left: '52px'}) ;
  	       Popup.close_parameter_window() ; 
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
  	) ; 
///////////////////////////////////////////
	},

	close_parameter_window : function() {
		Effect.Fade('params', {afterFinish : function() {
	 		document.body.style.overflow= 'auto' ;
	 		$('splash').remove() ;
	 		window.onscroll = null ; 
	 }});
	}
}

