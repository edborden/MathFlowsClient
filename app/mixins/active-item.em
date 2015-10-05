ActiveItem = Ember.Mixin.create
	
	active: false
	classNameBindings: ['active']
	click: ->
		unless @preview
			@setActiveItem @model
		false
	goActive: ->
		@active = true
	goInactive: ->
		@active = false

`export default ActiveItem`