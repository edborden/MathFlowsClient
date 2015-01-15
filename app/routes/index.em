class IndexRoute extends Ember.Route

	model: -> @session.me.flows.firstObject.documents.firstObject.pages.firstObject

`export default IndexRoute`