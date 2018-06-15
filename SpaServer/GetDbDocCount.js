//Requires
var Datastore = require('nedb')
  , db = new Datastore({ filename: './tasks.db', autoload: true });

db.count({}, function (error, count) {
  if (error) {
    console.log(error);
  } else {
    console.log(count + " docs total in DB");
  }
});