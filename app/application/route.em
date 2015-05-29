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
				@torii.open('google-oauth2').then (authData) => 
					console.log authData
					@session.post(authData.authorizationCode,authData.redirectUri).then => @transitionTo 'me'
					(error) -> console.log error
		openModal: (name,model) ->
			@modaler.openModal name,model
		closeModal: ->
			@modaler.closeModal()
		saveModel: (model) ->
			if model.isDirty
				model.save().then(
					(success) => console.log model.modelName + " saved."
					(errors) => @send 'errors', errors.errors
				)
		destroyModel: (model) ->
			model.destroyRecord().then(
				(success) => @notify.warning model.modelName + " destroyed."
				(errors) => @send 'errors', errors.errors
			)
		errors: (errors) -> 
			for prop,array of errors
				@notify.danger message for message in array

`export default ApplicationRoute`