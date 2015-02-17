class ApplicationRoute extends Ember.Route

	beforeModel: -> 
		@session.open().then (success) =>
			@sessionSuccessHandler()
			(error) =>
				@session.open().then => @sessionSuccessHandler()

	sessionSuccessHandler: ->
		@keen.pageView()

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
		authenticate: ->
			@torii.open('google-offline').then (authData) => 
				@session.post(authData.authorizationCode,authData.redirectUri).then =>
					@transitionTo 'me'
		openModal: (name,model) ->
			@render name,
				into: 'application'
				outlet: 'modal'
				model: model
		closeModal: ->
			@disconnectOutlet
				outlet: 'modal'
				parentView: 'application'

`export default ApplicationRoute`