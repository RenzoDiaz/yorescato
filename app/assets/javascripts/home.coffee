wheel = (event) ->
  delta = 0
  if event.wheelDelta
    delta = event.wheelDelta / 120
  else if event.detail
    delta = -event.detail / 3
  handle delta
  if event.preventDefault
    event.preventDefault()
  event.returnValue = false
  return

handle = (delta) ->
  time = 1000
  distance = 400
  $('html, body').stop().animate { scrollTop: $(window).scrollTop() - (distance * delta) }, time
  return

if window.addEventListener
  window.addEventListener 'DOMMouseScroll', wheel, false
window.onmousewheel = document.onmousewheel = wheel