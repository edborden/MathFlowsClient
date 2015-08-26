`import EmberValidations from 'ember-validations'`

class InviteBoxComponent extends Ember.Component with EmberValidations

	growler:Ember.inject.service()

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
			else
				@growler.growl @errors.email.firstObject
		
`export default InviteBoxComponent`