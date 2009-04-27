tinyMCEPopup.requireLangPack();

var UpImage = {
	init : function() {
		var pat_sys_id = window.opener.location.href.split("/")[4] ;
		var pat_id = window.opener.location.href.split("/")[6] ;
		new Ajax.Request("/pattern_systems/" + pat_sys_id + "/process_patterns/tmp_images/" + pat_id + ".js",{asynchronous:true, evalScripts:true, method:'get'}) ;
	},

	insert : function() {
		new Ajax.Request("/pattern_systems/" + pat_sys_id + "/process_patterns/tmp_upload/" + pat_id + ".js", {asynchronous: true, evalScripts: true, method:'post'}) ;
	},
	
	insert_image : function(filename) {
		// alert(filename);
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, '<img src=\'' + filename + '\' />') ;
		tinyMCEPopup.close() ;
	}
	
};

tinyMCEPopup.onInit.add(UpImage.init, UpImage);
