$('#proposal-gallery')
  .hammer()
  .on 'swipeleft', ->
    ($ @).carousel 'next'
  .on 'swiperight', ->
    ($ @).carousel 'prev'
