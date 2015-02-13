class ApplicationRoute extends Ember.Route

	beforeModel: -> 
		@session.open().then =>
			@keen.pageView()
			if @session.me.guest
				@replaceWith 'index'
			else
				@replaceWith 'me'
	
	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
		authenticate: ->
			@torii.open('google-offline').then (authData) => 
				@session.post(authData.authorizationCode,authData.redirectUri).then =>
					@transitionTo 'me'

`export default ApplicationRoute`