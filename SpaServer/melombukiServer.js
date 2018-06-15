//Requires
var app = require('express')();
var bodyParser = require('body-parser');
var multer = require('multer'); // v1.0.5
var upload = multer(); // for parsing multipart/form-data

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded


//Configure CORS for Kanban Task Board App
app.use(function (req, res, next) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

//Requires cont.
var http = require('http').Server(app);
var Datastore = require('nedb')
  , db = new Datastore({ filename: './tasks.db', autoload: true });

//Route to a simple info page
app.get('/', function (req, res) {
  res.sendFile(__dirname + '/index.html');
});

app.get('/tasks', function (req, res) {
  db.find({}, function (error, docs) {
    if (error) {
      console.log("Error getting docs");
    } else {
      res.send(docs);
    }
  });
});

app.get('/dashboard', function (req, res) {
  db.find({}, function (error, docs) {
    if (error) {
      console.log("Error getting docs");
    } else {
      res.send(docs);
    }
  });
});

app.get('/task/:id', function (req, res) {
  db.findOne({ _id: req.params.id }, function (error, doc) {
    if (error) {
      console.log(error);
    } else {
      res.send(doc);
    }
  });
});

app.post('/task/:id', upload.array(), function (req, res) {
  db.update({ _id: req.body.id }, req.body, {}, function (error, numReplaced, doc) {
    if (error) {
      res.sendStatus(500);
    } else {
      console.log(numReplaced + " doc will be updated");
      res.sendStatus(200);
    }
  });
});

app.post('/task', function (req, res) {
  db.insert(req.body, function (error, doc) {
    if (error) {
      console.log(error);
      res.status(500).send(error);
    } else {
      console.log(req.body);
      console.log(" will be added to the db.");
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.sendStatus(200);
    }
  });
});

app.post('/updatetask', function (req, res) {
  db.update({ "_id": req.body._id }, req.body, function (error) {
    if (error) {
      console.log(error);
      res.status(500).send(error);
    } else {

      console.log(req.body._id);
      console.log("Was updated");
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.sendStatus(200);
    }
  });
});

app.patch('/task', function (req, res) {
  console.log("Patched: " + req.body);
});

//Log that the server is running
http.listen(8001, function () {
  console.log('listening on *:8001');
});
