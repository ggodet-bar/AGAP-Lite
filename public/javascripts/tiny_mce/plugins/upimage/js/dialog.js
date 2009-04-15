tinyMCEPopup.requireLangPack();

var ExampleDialog = {
	init : function() {
		var f = document.forms[0];
		
		// Get the selected contents as text and place it in the input
		// f.someval.value = tinyMCEPopup.editor.selection.getContent({format : 'text'});
		// f.somearg.value = tinyMCEPopup.getWindowArg('some_custom_arg');		
		// 
	},

	insert : function() {
		// Insert the contents from the input into the document
		// tinyMCEPopup.editor.execCommand('mceInsertContent', false, document.forms[0].someval.value);
		// tinyMCEPopup.close();
		// alert(document.forms[0].file_upload.value);
		// alert(window.opener.location.href) ;
		new Ajax.Request("/process_patterns/tmp_upload/136429197.js", {asynchronous: true, evalScripts: true, method:'post'}) ;
		
	},
	
	test : function() {
		new Ajax.Request("/process_patterns/tmp_images/136429197.js",{asynchronous:true, evalScripts:true, method:'get'}) ;
		// $('images').setStyle({overflow: 'auto'}) ;
	},
	
	aTest : function() {
		alert('pouet') ;
	},
	
	insert_image : function(filename) {
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, '<img src=\'' + filename + '\' />') ;
		alert('did insert!') ;
		tinyMCEPopup.close() ;
	}
	
};

tinyMCEPopup.onInit.add(ExampleDialog.init, ExampleDialog);
