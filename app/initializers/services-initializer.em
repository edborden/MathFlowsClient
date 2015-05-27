initializer =

	initialize: (container,application) ->

		services = ['session','keen']

		#Inject into app factories
		['controller','route'].forEach (type) ->
			services.forEach (service) ->
				application.inject type, service, 'service:' + service

`export default initializer`