//Requires
var Datastore = require('nedb')
var db = new Datastore({ filename: './tasks.db', autoload: true });