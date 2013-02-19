# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#jQuery ->
#  if $('.pagination').length
#    $('#append_and_paginate').prepend('<a id="append_more_results" href="javascript:void(0);">Show more products</a>');
#    $('#append_more_results').click ->
#      url = $('.pagination .next_page').attr('href')
#      if url
#        $('.pagination').text('Fetching more products...')
#        $.getScript(url)

jQuery ->
  handleScroll = ->
    url = $('.pagination .next_page').attr('href')
    st = $(window).scrollTop()
    threshold = $(document).height() - 50
    windowHeight = window.innerHeight
    console.log "scrollTop:#{st}; Threshold:#{threshold}; url:#{url}, windowHieght:#{windowHeight}"
    if url && st + windowHeight > threshold
      console.log('=======Scrolled=======')
      $('.pagination').text("Loading more perps...")
      $.getScript(url)
  $(window).scroll handleScroll
  handleScroll()
