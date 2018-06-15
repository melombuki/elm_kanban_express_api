//Requires
var Datastore = require('nedb')
  , db = new Datastore({ filename: './tasks.db', autoload: true });

db.remove({}, { multi: true }, function (error, numRemoved) {
  if (error) {
    console.log(error);
  } else {
    console.log(`Successfully removed ${numRemoved} entries`);
  }
});