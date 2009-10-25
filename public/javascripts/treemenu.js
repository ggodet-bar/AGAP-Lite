// Should accept a json tree, as well as the current level in the tree
// or maybe, work on a standard list (for compatibility with browsers with JS deactivated)

// Script requires scriptaculous

if(Object.isUndefined(Effect) || Object.isUndefined(Prototype)) 
  throw("treemenu.js requires including script.aculo.us' effects.js library, as well as the Prototype library prototype.js");

var JsTreeMenu = {
	
	isFirstLevelPhase : false,
	currentNode : null,
	menuTopography : $H({}),	// Also used for storing the state of each node (OPENED or CLOSED or UNDEFINED)
	thePatterns : null,
	
	init : function() {		
		/*
		 *	We parse the list as a structured list (and sublists), which is passed to menuTopography
		 */
		// Get the pattern list in the patternList navigation bar
		thePatterns = $('patternList').down().next() ;	// Get the ul of the pattern list
		thePatterns.childElements().each(function(s) {	// Get all the li elements of the pattern list
			JsTreeMenu.recParseNode(s, true) ;

		}) ;
	},

	setCurrentNode : function(theNode) {
		JsTreeMenu.currentNode = theNode ;
	},

	recParseNode : function(node) {
		if (node.down() && node.down().next()) {	// check whether there is a sublist
				
				// Modify the currentNode so that it can blind up and down
				var closedTriangle = new Element('img', {src: "/images/common_images/triangle_closed.png", width: "10px", style:"border-width: 0px;"}) ;
				// var closedTriangle = new Element('div', {style: "width: 20px; height: 20px; background: url('../../public/images/common_images/triangle_closed.png'); float: left"}) ;
				// var link = new Element('a', {href: "javascript:void(0);"}).update(closedTriangle) ;
				// closedTriangle.setStyle({border-width: '0px'});
				// node.down().insert({'top' : " | "}) ;
				node.down().insert({'top' : closedTriangle}) ;
				
				closedTriangle.observe('click', JsTreeMenu.manageNode) ;
				JsTreeMenu.menuTopography.set(node.identify(), 'CLOSED');
				
				var subList = node.down().next() ;	// Get the ul of the sublist
				subList.childElements().each(function(s) {
					JsTreeMenu.recParseNode(s) ;
				}) ;
				subList.hide() ;
				
		}
	},
	
	manageNode : function(event) {
		var element = event.element().up().next() ;
		if (JsTreeMenu.menuTopography.get(element.up().identify()) == 'OPEN') {
			event.element().writeAttribute('src', "/images/common_images/triangle_closed.png") ;
			Effect.BlindUp(element, {duration : 0.3}) ;
			JsTreeMenu.menuTopography.set(element.up().identify(), 'CLOSED') ;
		} else {
			event.element().writeAttribute('src', "/images/common_images/triangle_opened.png") ;
			Effect.BlindDown(element, {duration : 0.3}) ;
			JsTreeMenu.menuTopography.set(element.up().identify(), 'OPEN') ;
		}
	
		return false;
	},
	
	openNode : function(nodeCoordinates) {
		// We consider that each pattern has a unique id
		// We open all the parent nodes, up to the root (which 
		// should not be in the menuTopography)
		var currentLevelId = $(nodeCoordinates).up().up().id ;
		
		var nodesList = $A([]) ;
		while (JsTreeMenu.menuTopography.get(currentLevelId) != null) {
			nodesList.push(currentLevelId) ;
			currentLevelId = $(currentLevelId).up().up().id ;
		}
		
		// We first reverse the hierarchy so that the top node gets opened first
		nodesList.reverse() ;
		nodesList.each(function(s){
	
			if (JsTreeMenu.menuTopography.get(s) == 'CLOSED') {
				$(s).down().down().writeAttribute('src', "/images/common_images/triangle_opened.png") ;
				Effect.BlindDown($(s).down().next(), {duration : 0}) ;
				JsTreeMenu.menuTopography.set(s, 'OPEN') ;
			}
		}) ;
	},
	
	setFirstLevelPhase : function(isPhase) {
		if (typeof(isPhase) == 'boolean' && isFirstLevelPhase != isPhase) {
			isFirstLevelPhase = isPhase ;
			// TODO Render the tree menu (maybe add some css?)
		}
	}
	
} ;

document.observe("dom:loaded", function() {
	JsTreeMenu.init() ;
	
	// TODO Maybe get the current node in order to open it!
	// JsTreeMenu.openNode(JsTreeMenu.currentNode) ;
}) ;