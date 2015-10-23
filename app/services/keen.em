`import config from 'math-flows-client/config/environment'`

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

class KeenService extends Ember.Service

	## ATTRIBUTES

	introClickPosition: null
	invitationId: null
	googleReferrer: null
	facebookReferrer: null

	## SERVICES

	session: service()
	structure: service()

	## COMPUTED

	me: alias 'session.me'
	webReferrer: computed -> document.referrer
	agent: computed -> window.navigator.userAgent
	structuredMe: computed 'me', -> @structure.structuredUser(@me) if @me?

	## CLIENT

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

	## EVENTS

	addEvent: (eventName,context=null) ->
		@client.addEvent eventName, 
			referrer: @webReferrer
			agent: @agent
			user: @structuredMe
			context: context

	introClick: ->
		if @introClickPosition?
			@addEvent 'introClick', 
				position: @introClickPosition
				invitationId: @invitationId
				googleReferrer: @googleReferrer
				facebookReferrer: @facebookReferrer

	addEditorEvent: (eventName,context) ->
		structuredContext = Ember.run.bind @structure, @structure.get("structured#{context.modelName}")

		contextObj =
			event: eventName

		contextObj[context.modelKey] = structuredContext context

		@addEvent "editorEvent", contextObj

`export default KeenService`