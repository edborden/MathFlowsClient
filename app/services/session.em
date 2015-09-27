class SessionService extends Ember.Service

	store: Ember.inject.service()
	modeler:Ember.inject.service()

	loggedIn: ~> @model?
	model: null
	token: ~> if @model? then @model.token else null
	me: ~> @model.user
	
	open: ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			token = localStorage.mathFlowsToken
			if token?
				@store.query('session', {token: token}).then(
					(response) => 
						@model = response.objectAt(0)
						resolve()
					(errors) => 
						console.log errors
						if errors.errors[0].status is "401"
							@close()
							console.log "401!"
						reject()
				)
			else
				@post('issue').then => resolve()

	post: (token,redirectUri) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			session = @store.createRecord('session',{token:token,redirectUri:redirectUri})
			@modeler.saveModel(session).then(
				(response) => 
					@model = response
					localStorage.mathFlowsToken = @token
					resolve()
				(errors) => 
					console.log errors
					@close() if errors.errors[0].status is "401"
					reject()
			)

	close: ->
		localStorage.clear()
		@model = null

`export default SessionService`