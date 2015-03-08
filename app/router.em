`import config from './config/environment'`

class Router extends Ember.Router
	location: config.locationType

Router.map ->
	@route 'block', {path: '/block/:block_id'}
	@route 'page', {path: '/page/:page_id'}
	@route 'me'
	@route 'document', {path: '/document/:document_id'}
	@route 'headers'
	@route 'application_loading'

`export default Router`