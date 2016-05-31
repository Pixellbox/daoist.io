$('#proposal-gallery')
  .hammer()
  .on 'swipeleft', ->
    ($ @).carousel 'next'
  .on 'swiperight', ->
    ($ @).carousel 'prev'

$('a[data-scrolltop]').on 'click', ->
  $('html, body').stop().animate
    scrollTop: 0
  , 150
