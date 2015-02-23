`import EmberValidations from 'ember-validations'`
`import Notify from 'ember-notify'`

class InviteBoxComponent extends Ember.Component with EmberValidations.Mixin

	validations:
		email:
			format: 
				with: /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i
				message: "Doesn't look like a valid email. Please try again."

	invite: 'invite'
	email: null

	actions:
		inviteClicked: ->
			if @isValid
				@sendAction 'invite',@email
				@email = null
				Notify.warning "Invitation sent! Thanks!"
			else
				Notify.warning @errors.email.firstObject
		
`export default InviteBoxComponent`