initializer =

	initialize: (container,application) ->

		services = ['session','keen','modaler']

		#Inject into app factories
		['controller','route'].forEach (type) ->
			services.forEach (service) ->
				application.inject type, service, 'service:' + service

		# Router as Service
		application.inject 'component:try-button', 'router', 'router:main'
		application.inject 'component:groupvitation-received', 'router', 'router:main'

`export default initializer`