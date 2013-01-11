# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#redditPost").click (e) ->
      e.preventDefault()
      url = $(this).attr("href")
      $ window.open(url, "Reddit", "status = 1, height = 850, width = 1000, resizable = 0" )
