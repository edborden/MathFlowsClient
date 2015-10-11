`import growl from 'math-flows-client/utils/growl'`
`import EmberValidations from 'ember-validations'`

class InviteBoxComponent extends Ember.Component with EmberValidations

	validations:
		email:
			format: 
				with: /@/
				message: "Doesn't look like a valid email. Please try again."

	invite: 'invite'
	email: null

	actions:
		inviteClicked: ->
			if @isValid
				@sendAction 'invite',@email
				@email = null
			else
				growl @errors.email.firstObject
		
`export default InviteBoxComponent`