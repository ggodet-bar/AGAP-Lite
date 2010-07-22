// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Used for pattern system edition */
function remove_fields(link) {
  // Set the hidden field to true
  $(link).next('input[type=hidden]').value = "1" ;
  // Hide the surrounding tag 
  $(link).up('.patternSystemClassification').hide() ; 
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime() ;
  var regexp = new RegExp("new_" + association, "g")
  // We make sure we generate a unique id for each set of field
  $(link).insert({
    before: content.replace(regexp, new_id)
  }) ;

}

// We disable the console when firebug is not loaded
if (!("console" in window) || !("firebug" in console)) {
 var names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"];
 window.console = {};
 for (var i = 0, len = names.length; i < len; ++i) {
 window.console[names[i]] = function(){};
 }
}


