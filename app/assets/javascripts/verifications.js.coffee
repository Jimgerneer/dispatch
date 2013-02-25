# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  window.openWindow = (url) ->
      $ window.open(url, "Reddit", "status = 1, height = 850, width = 800, resizable = 0" )

  $("#verification_link li a" ).click (e) ->
      e.preventDefault()
      openWindow $(this).attr("href")
