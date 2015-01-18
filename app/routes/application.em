class ApplicationRoute extends Ember.Route

	beforeModel: -> @session.open()
	
	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
		authenticate: ->
			@torii.open('google-offline').then (authData) => 
				console.log authData
				@session.post(authData.authorizationCode).then =>
					@transitionTo 'me'

`export default ApplicationRoute`