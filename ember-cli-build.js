/* global require, module */

var env = process.env.EMBER_ENV;
var config = require('./config/environment')(env);

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {
	var app = new EmberApp(defaults, {
		inlineContent:{
			'body': {content: "<div class='center-spinner'><i class='fa fa-4x fa-spinner fa-pulse'></i></div>"}
		}
	});

	if (config.onLine) {
		app.options.inlineContent['userSnap'] = {content:"<script type='text/javascript'>(function(){var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//api.usersnap.com/load/'+ 'bc7d2656-cad4-43ee-8f81-eabc3ed4e4aa.js'; var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x); })(); </script>"};
		app.options.inlineContent['droidFont'] = {content:"<link href='http://fonts.googleapis.com/css?family=Damion|Droid+Sans' rel='stylesheet' type='text/css'>"};
		app.options.inlineContent['desmos'] = {content:"<script src='https://www.desmos.com/api/v0.4/calculator.js?apiKey=dcb31709b452b1cf9dc26972add0fda6'></script>"};
		app.options.inlineContent['cloudinary'] = {content:"<script src='//widget.cloudinary.com/global/all.js' type='text/javascript'></script>"};
		app.options.inlineContent['rewRelic'] = {file:"new-relic.js"};		
	};

	var pickFiles = require('broccoli-funnel');
	var mergeTrees = require('broccoli-merge-trees');

	// Font-Awesome
	var fontAwesomeFonts = pickFiles('bower_components/components-font-awesome/fonts', {
		destDir: '/fonts'
	});

	// Keen.io
	app.import('bower_components/keen-js/dist/keen.min.js');

	// Bootstrap
	app.import('bower_components/bootstrap/js/modal.js');

	// MathQuill
	app.import('vendor/mathquill/mathquill.js');
	var mathQuillFonts = pickFiles('vendor/mathquill/font', {
		destDir: '/fonts'
	});

	// Cloudinary
	app.import('bower_components/blueimp-file-upload/js/vendor/jquery.ui.widget.js');
	app.import('bower_components/blueimp-file-upload/js/jquery.iframe-transport.js');
	app.import('bower_components/blueimp-file-upload/js/jquery.fileupload.js');
	app.import('bower_components/cloudinary_js/js/jquery.cloudinary.js');

	// JQuery UI for Drag/Drop and Gridstack
	app.import('bower_components/jquery-ui/ui/core.js');
	app.import('bower_components/jquery-ui/ui/widget.js');
	app.import('bower_components/jquery-ui/ui/mouse.js');
	app.import('bower_components/jquery-ui/ui/draggable.js');
	app.import('bower_components/jquery-ui/ui/droppable.js');
	app.import('bower_components/jquery-ui/ui/resizable.js');

	// Gridstack
	app.import('bower_components/lodash/lodash.js');
	app.import('bower_components/gridstack/src/gridstack.js');

	return mergeTrees([app.toTree(),fontAwesomeFonts,mathQuillFonts]);
};
