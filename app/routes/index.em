class IndexRoute extends Ember.Route

	model: -> @session.me.layouts.firstObject

`export default IndexRoute`