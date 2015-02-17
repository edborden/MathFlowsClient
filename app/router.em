`import config from './config/environment'`

class Router extends Ember.Router
	location: config.locationType

Router.map ->
	@route 'block', {path: '/block/:block_id'}
	@route 'page', {path: '/page/:page_id'}
	@route 'me'
	@route 'document', {path: '/document/:document_id'}
	@route 'invitation', {path: '/invitation/:invitation_id'}

`export default Router`