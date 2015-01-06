/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

require('broccoli-ember-script')(app.toTree())

var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

// jspdf
app.import('bower_components/html2canvas/build/html2canvas.min.js');
app.import('bower_components/jspdf/dist/jspdf.min.js');

// Gridster
app.import('bower_components/gridster.js/dist/jquery.gridster.min.js');
app.import('bower_components/gridster.js/dist/jquery.gridster.min.css');

module.exports = mergeTrees([app.toTree()]);
