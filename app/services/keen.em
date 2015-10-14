`import config from 'math-flows-client/config/environment'`

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

class KeenService extends Ember.Service

	## SERVICES

	session: service()
	structure: service()

	## COMPUTED

	me: alias 'session.me'
	webReferrer: computed -> document.referrer
	agent: computed -> window.navigator.userAgent

	client: computed -> 
		if config.environment is 'production'
			new Keen
				projectId: config.keenProjectId
				writeKey: config.keenWriteKey
				protocol: "auto"
				host: "api.keen.io/3.0"
				requestType: "jsonp"
		else
			{addEvent: -> return}

	addEvent: (eventName,context=null) ->
		@client.addEvent eventName, 
			referrer: @webReferrer
			agent: @agent
			user: @structure.structuredUser @me
			context: context

	introClickPosition: null
	invitationId: null
	introClick: ->
		if @introClickPosition?
			@addEvent 'introClick', 
				position: @introClickPosition
				invitationId: @invitationId

	addBlockEvent: (eventName,block) ->
		@addEvent "blockEvent", 
			event: eventName
			block: @structure.structuredBlock block

`export default KeenService`