class SessionService extends Ember.Service

	loggedIn: ~> @model?
	model: null
	token: ~> if @model? then @model.token else null
	me: ~> @model.user
	
	open: ->
		return new Ember.RSVP.Promise (resolve) =>
			token = localStorage.mathFlowsToken
			if token?
				@store.find('session', {token: token}).then(
					(response) => 
						@model = response.objectAt(0)
						resolve response
					(error) -> 
						localStorage.clear() if error.status is 401
						resolve error
				)
			else
				@post('issue').then => resolve()

	post: (token,redirectUri) ->
		return new Ember.RSVP.Promise (resolve) =>
			@store.createRecord('session',{token:token,redirectUri:redirectUri}).save().then(
				(response) => 
					console.log 'success'
					@model = response
					localStorage.mathFlowsToken = @token
					resolve()
				(error) => 
					console.log error
					@close() if error.status is 401
					resolve()
			)

	close: ->
		localStorage.clear()
		@model = null

`export default SessionService`