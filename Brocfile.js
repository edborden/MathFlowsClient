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

// MathQuill
app.import('vendor/mathquill/mathquill.js');
var mathQuillFonts = pickFiles('vendor/mathquill/font', {
    srcDir: '/',
	destDir: '/fonts'
});

// Cloudinary
app.import('bower_components/blueimp-file-upload/js/vendor/jquery.ui.widget.js');
app.import('bower_components/blueimp-file-upload/js/jquery.iframe-transport.js');
app.import('bower_components/blueimp-file-upload/js/jquery.fileupload.js');
app.import('bower_components/cloudinary_js/js/jquery.cloudinary.js');

module.exports = mergeTrees([app.toTree(),fontAwesomeFonts,mathQuillFonts]);