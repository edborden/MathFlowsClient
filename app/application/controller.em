class ApplicationController extends Ember.Controller

	indexRoute: ~> @currentRouteName is 'index'
	meRoute: ~> @currentRouteName is 'me'
	loginRoute: ~> @currentRouteName is 'login'

`export default ApplicationController`