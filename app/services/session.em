class SessionService extends Ember.Object

	loggedIn: ~> if @model? then return true else return false
	model: null
	token: ~> if @model? then return @model.token else return null
	me: ~> @model.user
	
	open: ->
		return new Ember.RSVP.Promise (resolve) =>
			token = localStorage.mathFlowsToken
			if token?
				@store.find('session', {token: token}).then(
					(response) => 
						@model = response.objectAt(0)
						resolve()
					(error) -> 
						localStorage.clear() if error.status is 401
						resolve()
				)
			else
				@post('issue').then => resolve()

	post: (token) ->
		return new Ember.RSVP.Promise (resolve) =>
			@store.createRecord('session',{token: token}).save().then(
				(response) => 
					@model = response
					localStorage.mathFlowsToken = @token
					resolve()
				(error) => 
					@close() if error.status is 401
					resolve()
			)

	close: ->
		localStorage.clear()
		@model = null

`export default SessionService`