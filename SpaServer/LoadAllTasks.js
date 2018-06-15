//Requires
var Datastore = require('nedb')
  , db = new Datastore({ filename: './tasks.db', autoload: true });

var TASKS = [
  {
    id: "1"
    , name: "Learn more Elm"
    , description: "Read more about Elm and use it."
    , status: "InProgress"
  },
  {
    id: "2"
    , name: "Go to sleep"
    , description: "Lie down and close your eyes all night."
    , status: "InProgress"
  },
  {
    id: "3"
    , name: "Get in bed"
    , description: "Walk into the bedroom and lay down on the bed."
    , status: "Done"
  },
  {
    id: "4"
    , name: "Dream well"
    , description: "Have really good dreams."
    , status: "InProgress"
  },
  {
    id: "5"
    , name: "Learn Rust"
    , description: "Find a good book or website and read it and write something in Rust."
    , status: "Todo"
  }
];

db.insert(TASKS, function (error, newDocs) {
  if (error) {
    console.log(error);
  } else {
    console.log(`Successfully inserted ${newDocs.length} documents`);
  }
});