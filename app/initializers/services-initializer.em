`import SessionService from 'math-flows-client/services/session'`

initializer =
	name:'services'
	after: 'store'
	initialize: (container,application) ->

		#Register service objects
		application.register 'service:session', SessionService, {singleton: true}

		#Setup service objects
		application.inject 'service:session', 'store', 'store:main'

		#Inject into app factories
		['controller','route','model','adapter'].forEach (type) ->
			application.inject type, 'session', 'service:session'
		application.inject 'model:layout', 'session', 'service:session'

`export default initializer`