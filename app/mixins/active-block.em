ActiveBlock = Ember.Mixin.create

	activeBlock: null

	actions:
	
		setActiveBlock: (block) ->
			@activeBlock = block
			
		setInactiveBlock: (block) ->
			if @activeBlock is block
				@activeBlock = null

`export default ActiveBlock`