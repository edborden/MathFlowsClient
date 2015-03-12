class ApplicationRoute extends Ember.Route

	beforeModel: -> 
		@session.open().then (success) =>
			@sessionSuccessHandler()
			(error) =>
				console.log error
				@session.open().then => @sessionSuccessHandler()

	sessionSuccessHandler: ->
		@keen.log_session()
		Ember.$(".center-spinner").hide()

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
		authenticate: ->
			@transitionTo('loading').then =>
				@torii.open('google-offline').then (authData) => 
					console.log authData
					@session.post(authData.authorizationCode,authData.redirectUri).then => @transitionTo 'me'
					(error) -> console.log error

		openModal: (name,model) ->
			@render name,
				into: 'application'
				outlet: 'modal'
				model: model
		closeModal: ->
			@disconnectOutlet
				outlet: 'modal'
				parentView: 'application'
		addImage: (params) ->
			@store.createRecord('image',params).save()
`export default ApplicationRoute`