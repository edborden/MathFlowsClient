`import config from 'math-flows-client/config/environment'`

ServerTalk = Ember.Mixin.create
	host: config.apiHostName
	session: Ember.inject.service()

	headers: ~>
		if @session.token?
			return {'Authorization': 'Bearer ' + @session.token }
		else
			return {}

	postServer: (url,data = {},dataType = "text") -> 
		@httpServer url,data,dataType,"POST"

	deleteServer: (url,data = {},dataType = "text") -> 
		@httpServer url,data,dataType,"DELETE"

	httpServer: (url,data = {},dataType = "text",type) ->
		return new Ember.RSVP.Promise (resolve) =>
			Ember.$.ajax 
				data: data
				url: @host + "/" + url + ".json"
				success: (response) => 
					resolve response
				dataType: dataType
				headers: @headers
				type: type
				crossDomain: true

`export default ServerTalk`