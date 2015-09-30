ActiveItem = Ember.Mixin.create
	
	activeItem: null
	active: Ember.computed "activeItem", -> @activeItem is @model
	classNameBindings: ['active']
	click: ->
		unless @preview
			@setActiveItem @model
		false

`export default ActiveItem`