class MeRoute extends Ember.Route

	beforeModel: -> @replaceWith 'index' if @session.me.guest

	model: -> @session.me

`export default MeRoute`