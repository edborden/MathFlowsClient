`import config from './config/environment'`

class Router extends Ember.Router
	location: config.locationType

Router.map ->
	@route 'block', ->
		@route 'edit', {path: '/edit/:block_id'}

`export default Router`