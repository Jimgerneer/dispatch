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
//= require twitter/bootstrap
//= require_tree .

$(function() {
  $('.popover_help').popover( {trigger: 'focus'})
  updateOnlineStatus()
});

window.openRedditWindow = function(url) {
  return $(window.open(url, "Reddit", "status = 1, height = 850, width = 1000, resizable = 0"));
};

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-38261203-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

window.onlineList = null;
window.onlineListAge = null;

window.updateOnlineList = function(callback) {
  $.getJSON('http://whateverorigin.org/get?url=' + encodeURIComponent('http://skynet.nickg.org/online.json') + '&callback=?', function(data){
      onlineList = data.contents;
      onlineListAge = new Date();
      if (typeof (callback) == 'function')
        callback()
  });
};

window.serverPlayerList = function() {
  $.getJSON('http://whateverorigin.org/get?url=' + encodeURIComponent('http://skynet.nickg.org/players.json') + '&callback=?', function(data){ 
    var names = data.contents;
    $('.perpetrator input').data('typeahead').source = names;
  });
};

window.updateOnlineStatus = function() {
  if (onlineListAge == null) {
    var onlineListAge = new Date();
  }

  var currentTime = new Date();
  var dif = currentTime.getTime() - onlineListAge.getTime();

  var secondsFrom = dif / 1000;
  var secondsBetweenUpdates = Math.abs(secondsFrom);

  if (onlineList == null || secondsBetweenUpdates >= 60) {
    updateOnlineList(updateOnlineStatus)
  } else {
    $.each(onlineList, function(name, timestamp) { $('#perp-'+name).addClass('online') });
  }
};
