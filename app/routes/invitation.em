class InvitationRoute extends Ember.Route

	afterModel: (model) ->
		model.referral = @session.me
		model.save()
		@replaceWith 'index'

`export default InvitationRoute`