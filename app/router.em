`import config from './config/environment'`

class Router extends Ember.Router
	location: config.locationType

Router.map ->
	@route 'block', {path: '/block/:block_id'}
	@route 'editor'

`export default Router`