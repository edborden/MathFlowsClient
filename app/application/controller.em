computed = Ember.computed
equal = computed.equal

class ApplicationController extends Ember.Controller

  indexRoute: equal 'currentRouteName', 'index'
  meRoute:  equal 'currentRouteName', 'me'
  loginRoute:  equal 'currentRouteName', 'login'
  year: computed -> 
    date = new Date
    date.getFullYear()

`export default ApplicationController`