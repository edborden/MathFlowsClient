computed = Ember.computed
equal = computed.equal

class ApplicationController extends Ember.Controller

	indexRoute: equal 'currentRouteName', 'index'
	meRoute:  equal 'currentRouteName', 'me'
	loginRoute:  equal 'currentRouteName', 'login'

`export default ApplicationController`