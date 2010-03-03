var Popup = {
        func_name: null,
        func_args: null,

        // Arguments should be passed as an array
        install_callback: function(func, args) {
          if (func) {
            console.log("The arguments are " + args) ;
            Popup.func_name= func ;
            Popup.func_args = args ;
          }
        },

        toggle: function(popup_id) {
          if ($('splash_137')) {
            Popup.close(popup_id) ;
          } else {
            Popup.open(popup_id) ;
          }
        },

	open : function(popup_id) {
	document.body.style.overflow = "hidden" ;
  	window.onscroll=function() { window.scrollTo(0,0) }
  	var body_size = null ;
  	if (document.documentElement) {
  	 body_size = {	width : document.documentElement.clientWidth,
  	      	  	height : document.documentElement.clientHeight};
  	} else {
  	        body_size = document.body.getDimensions() ;
  	} 
  	var splash = new Element('div', {id : 'splash_137', style: 'position: fixed; left: -10px; top: -10px; width: ' + body_size.width * 1.1 + 'px;height: ' + body_size.height * 1.1 + 'px; background-color: #000; z-index: 1000' });
  	splash.setOpacity(0.5) ;
  	Element.insert(document.body,{'top' : splash}) ;

        // Call the function that finalizes the setup of
        // the system
        Popup.func_name.apply(this, Popup.func_args) ;

        // Add a key observer for exiting the popup
        document.observe('keydown', function(event) {
          if (event.keyCode == 27) {
            document.stopObserving('keydown', this) ;  
            Popup.close(popup_id) ;
          }
        }) ;

        // The popup should be appearing
        $(popup_id).appear() ;
	},

	close : function(popup_id) {
                // N.B The fadeout is triggered once all the preceding Effects
                // have been resolved (hence the queue parameter)
		Effect.Fade(popup_id, {queue: 'end', afterFinish : function() {
	 		document.body.style.overflow= 'auto' ;
	 		if ($('splash_137')) {
                          $('splash_137').remove() ;
                        }
	 		window.onscroll = null ; 
	 }});
	}
}

