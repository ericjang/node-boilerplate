NotFound = (msg) ->
  @name = "NotFound"
  Error.call this, msg
  Error.captureStackTrace this, arguments_.callee
connect = require("connect")
express = require("express")
io = require("socket.io")
port = (process.env.PORT or 8081)
app = express()
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view options",
    layout: false

  app.use connect.bodyParser()
  app.use express.cookieParser()
  app.use express.session(secret: "shhhhhhhhh!")
  app.use connect.static(__dirname + "/static")
  app.use app.router
  app.use (err, req, res, next) ->
    console.error err.stack
    if err instanceof NotFound
      res.render "404.jade",
        locals:
          title: "404 - Not Found"
          description: ""
          author: ""
          analyticssiteid: "XXXXXXX"

        status: 404
    else
      res.render "500.jade",
        locals:
          title: "The Server Encountered an Error"
          description: ""
          author: ""
          analyticssiteid: "XXXXXXX"
          error: err

        status: 500

app.listen port
io = io.listen(app)
io.configure "production", ->
  io.set "log level", 1

io.sockets.on "connection", (socket) ->
  console.log "Client Connected"
  socket.on "message", (data) ->
    socket.broadcast.emit "app_message", data
    socket.emit "app_message", data

  socket.on "disconnect", ->
    console.log "Client Disconnected."

app.get "/", (req, res) ->
  res.render "index.jade",
    locals:
      title: "Your Page Title"
      description: "Your Page Description"
      author: "Your Name"
      analyticssiteid: "XXXXXXX"

app.get "/about", (req, res) ->
  res.render "about.jade",
    locals:
      title: "Your Page Title"
      description: "Your Page Description"
      author: "Your Name"
      analyticssiteid: "XXXXXXX"

app.get "/contact", (req, res) ->
  res.render "contact.jade",
    locals:
      title: "Your Page Title"
      description: "Your Page Description"
      author: "Your Name"
      analyticssiteid: "XXXXXXX"

app.get "/500", (req, res) ->
  throw new Error("This is a 500 Error")

app.get "/*", (req, res) ->
  throw new NotFound

console.log "Listening on http://0.0.0.0:" + port