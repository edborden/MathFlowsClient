/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

// Font-Awesome
var fontAwesomeFonts = pickFiles('bower_components/components-font-awesome/fonts', {
    srcDir: '/',
	destDir: '/fonts'
});

// Gridster
app.import('bower_components/gridster.js/dist/jquery.gridster.js');
app.import('bower_components/gridster.js/dist/jquery.gridster.min.css');

// Keen.io
app.import('bower_components/keen-js/dist/keen.min.js');

// Bootstrap Modal
app.import('bower_components/bootstrap/js/modal.js');

module.exports = mergeTrees([app.toTree(),fontAwesomeFonts]);