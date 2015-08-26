`import config from 'math-flows-client/config/environment'`

class ServerService extends Ember.Service
	host: config.apiHostName
	session: Ember.inject.service()
	store: Ember.inject.service()

	headers: ~>
		if @session.token?
			return {'Authorization': 'Bearer ' + @session.token }
		else
			return {}

	post: (url,data = {}) -> 
		@http url,data,"POST"

	delete: (url,data = {}) -> 
		@http url,data,"DELETE"

	http: (url,data,type) ->
		return new Ember.RSVP.Promise (resolve) =>
			Ember.$.ajax 
				data: data
				url: @host + "/" + url + ".json"
				success: (response) =>
					@store.pushPayload response
					resolve response
				dataType: "json"
				headers: @headers
				type: type
				crossDomain: true

`export default ServerService`