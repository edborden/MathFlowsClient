class ApplicationRoute extends Ember.Route

	beforeModel: -> 
		if localStorage.mathFlowsToken
			@session.open().then (success) =>
				@sessionSuccessHandler()
				(error) =>
					console.log error
					@session.open().then => @sessionSuccessHandler()
		else
			Ember.$(".center-spinner").hide()

	sessionSuccessHandler: ->
		@keen.log_session()
		Ember.$(".center-spinner").hide()

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'

		authenticate: ->
			@transitionTo('loading').then =>
				@torii.open('google-oauth2').then( 
					(authData) => 
						console.log authData
						@session.post(authData.authorizationCode,authData.redirectUri).then => @transitionTo 'me'
					(error) -> console.log error
				)

		saveModel: (model) ->
			if model.isDirty
				model.save().then(
					(success) => console.log model.modelName + " saved."
					(errors) => @send 'errors', errors.errors
				)
			else
				console.log model.modelName + " isn't dirty."

		destroyModel: (model) ->
			model.destroyRecord().then(
				(success) => @notify.warning model.modelName + " destroyed."
				(errors) => @send 'errors', errors.errors
			)

		errors: (errors) -> 
			for prop,array of errors
				@notify.danger message for message in array

`export default ApplicationRoute`