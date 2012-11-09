$(document).ready ->
  socket = io.connect()
  $("#sender").bind "click", ->
    socket.emit "message", "Message Sent on " + new Date()

  socket.on "server_message", (data) ->
    $("#receiver").append "<li>" + data + "</li>"