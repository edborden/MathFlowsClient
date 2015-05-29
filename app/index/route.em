class IndexRoute extends Ember.Route

	beforeModel: -> @replaceWith 'me' if @session.loggedIn and not @session.me.guest

`export default IndexRoute`