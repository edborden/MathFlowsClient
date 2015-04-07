class IndexRoute extends Ember.Route

	beforeModel: -> @replaceWith 'me' unless @session.me.guest

`export default IndexRoute`