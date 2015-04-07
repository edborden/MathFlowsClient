`import SessionService from 'math-flows-client/services/session'`
`import KeenService from 'math-flows-client/services/keen'`

initializer =
	name:'services'
	after: 'store'
	initialize: (container,application) ->

		#Register service objects
		application.register 'service:session', SessionService, {singleton: true}
		application.register 'service:keen', KeenService, {singleton: true}
		services = ['session','keen']

		#Setup service objects
		application.inject 'service:session', 'store', 'store:main'
		application.inject 'service:keen', 'session', 'service:session'

		#Inject into app factories
		['controller','route','model:test','model:block','model:group','adapter'].forEach (type) ->
			services.forEach (service) ->
				application.inject type, service, 'service:' + service

`export default initializer`