class VoicerService extends Ember.Service

	session: Ember.inject.service()

	setup: ->
		unless @session.me.guest
			options = 
				accent_color: '#e2753a'
				trigger_color: 'white'
				trigger_background_color: '#e2753a'
			UserVoice.push ['set', options]

			###
			UserVoice.push ['identify',
			//email:      'john.doe@example.com'
			//name:       'John Doe', // User’s real name
			//created_at: 1364406966, // Unix timestamp for the date the user signed up
			//id:         123, // Optional: Unique id of the user (if set, this should not change)
			//type:       'Owner', // Optional: segment your users by type
			//account: {
			//  id:           123, // Optional: associate multiple users with a single account
			//  name:         'Acme, Co.', // Account name
			//  created_at:   1364406966, // Unix timestamp for the date the account was created
			//  monthly_rate: 9.99, // Decimal; monthly rate of the account
			//  ltv:          1495.00, // Decimal; lifetime value of the account
			//  plan:         'Enhanced' // Plan name for the account
			]
			###

			UserVoice.push ['addTrigger', {mode: 'contact', trigger_position: 'bottom-left' }]

`export default VoicerService`