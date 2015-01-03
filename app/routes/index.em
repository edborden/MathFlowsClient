class IndexRoute extends Ember.Route

	model: -> @session.me.grids.firstObject

`export default IndexRoute`