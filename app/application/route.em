class ApplicationRoute extends Ember.Route

	growler:Ember.inject.service()
	voicer:Ember.inject.service()

	beforeModel: -> 
		if localStorage.mathFlowsToken
			@session.open().then (success) =>
				@sessionSuccessHandler()
				(error) =>
					@growler.muted error
					@session.open().then => @sessionSuccessHandler()
		else
			Ember.$(".center-spinner").hide()

	sessionSuccessHandler: ->
		@keen.logSession()
		Ember.$(".center-spinner").hide()
		@voicer.setup()

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'

		authenticate: ->
			@transitionTo('loading').then =>
				@torii.open('google-oauth2').then( 
					(authData) => 
						@growler.muted authData
						@session.post(authData.authorizationCode,authData.redirectUri).then => 
							@transitionTo 'me'
							@voicer.setup()
					(error) => @growler.growl error
				)

		closeModal: -> @modaler.closeModal()

`export default ApplicationRoute`