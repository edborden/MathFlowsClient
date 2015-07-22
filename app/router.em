`import config from './config/environment'`

class Router extends Ember.Router
	location: config.locationType

Router.map ->
	@route 'page', {path: '/page/:page_id'}
	@route 'me'
	@route 'intro'
	@route 'login'
	@route 'invitations'
	@route 'preferences', ->
		@route 'display'
		@route 'headers'

`export default Router`