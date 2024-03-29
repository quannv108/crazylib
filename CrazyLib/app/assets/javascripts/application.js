// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require_tree .
 
function onChangeLocale(lang) {
    var newURL = "";
    var andMarkLocation = document.URL.indexOf("&");
    var questionMarkLocation = document.URL.indexOf("?");
    if(andMarkLocation != -1){
    	var localeMarkLocation = document.URL.indexOf("&locale")
    	if(localeMarkLocation != -1){
    		newURL = document.URL.substring(0, localeMarkLocation) + "&locale=" + lang;
    	}else{
    		newURL = document.URL + "&locale=" + lang;
    	}
    }else {
    	if (questionMarkLocation != -1) {
        	newURL = document.URL.substring(0, questionMarkLocation); 
    	} else {
        	newURL = document.URL;
       	}
       	newURL = newURL + "?locale=" + lang;
    }
    document.location=newURL;
}
    
