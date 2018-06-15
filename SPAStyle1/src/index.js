'use strict';

require('!style-loader!css-loader!../node_modules/semantic-ui-css/semantic.css');

// Require index.html so it gets copied to dist
require('./index.html');

let Elm = require('./elm/Main.elm');
let mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
let app = Elm.Main.embed(mountNode);
