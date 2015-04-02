class IndexRoute extends Ember.Route

	beforeModel: -> @replaceWith 'me' unless @session.me.guest

	model: -> @session.me.folders.firstObject.flows.firstObject

`export default IndexRoute`