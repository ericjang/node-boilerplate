//setup Dependencies
var connect = require('connect')
    , express = require('express')
    , io = require('socket.io')
    , port = (process.env.PORT || 8081);


/*
Set up MongoDB like this for heroku apps

var mongourl = (process.env.NODE_ENV == 'production') ? process.env.MONGOHQ_URL : 'localhost:27017/pulpierfiction_db'
	,	db = mongo.db(mongourl)
	, stories = db.collection('stories')
	, users = db.collection('users');

*/



/*
Define your Mongoose Schema here

*/


//Setup Express
var app = express();
app.configure(function(){
    app.set('views', __dirname + '/views');
    app.set('view options', { layout: false });
    app.use(connect.bodyParser());
    app.use(express.cookieParser());
    app.use(express.session({ secret: "shhhhhhhhh!"}));
    app.use(connect.static(__dirname + '/static'));
    app.use(app.router);
		//error handling compliant with Express 3.x
		app.use(function(err, req, res, next){
			console.error(err.stack);
	    if (err instanceof NotFound) {
	        res.render('404.jade', { locals: { 
	                  title : '404 - Not Found'
	                 ,description: ''
	                 ,author: ''
	                 ,analyticssiteid: 'XXXXXXX' 
	                },status: 404 });
	    } else {
	        res.render('500.jade', { locals: { 
	                  title : 'The Server Encountered an Error'
	                 ,description: ''
	                 ,author: ''
	                 ,analyticssiteid: 'XXXXXXX'
	                 ,error: err 
	                },status: 500 });
	    }
		});
});

app.listen(port);

//Setup Socket.IO
var io = io.listen(app);

io.configure('production',function(){
	//un-comment 'transports' and 'polling duration' for Heroku, until they implement WebSockets
	//io.set("transports",["xhr-polling"]);
	//io.set("polling duration",10);
	io.set("log level",1);
});

io.sockets.on('connection', function(socket){
  console.log('Client Connected');
  socket.on('message', function(data){
    socket.broadcast.emit('app_message',data);
    socket.emit('app_message',data);
  });
  socket.on('disconnect', function(){
    console.log('Client Disconnected.');
  });
});


///////////////////////////////////////////
//              Routes                   //
///////////////////////////////////////////

/////// ADD ALL YOUR ROUTES HERE  /////////

app.get('/', function(req,res){
  res.render('index.jade', {
    locals : { 
              title : 'Your Page Title'
             ,description: 'Your Page Description'
             ,author: 'Your Name'
             ,analyticssiteid: 'XXXXXXX' 
            }
  });
});

app.get('/about', function(req,res){
  res.render('about.jade', {
    locals : { 
              title : 'Your Page Title'
             ,description: 'Your Page Description'
             ,author: 'Your Name'
             ,analyticssiteid: 'XXXXXXX' 
            }
  });
});

app.get('/contact', function(req,res){
  res.render('contact.jade', {
    locals : { 
              title : 'Your Page Title'
             ,description: 'Your Page Description'
             ,author: 'Your Name'
             ,analyticssiteid: 'XXXXXXX' 
            }
  });
});


//A Route for Creating a 500 Error (Useful to keep around)
app.get('/500', function(req, res){
    throw new Error('This is a 500 Error');
});

//The 404 Route (ALWAYS Keep this as the last route)
app.get('/*', function(req, res){
    throw new NotFound;
});

function NotFound(msg){
    this.name = 'NotFound';
    Error.call(this, msg);
    Error.captureStackTrace(this, arguments.callee);
}


console.log('Listening on http://0.0.0.0:' + port );
