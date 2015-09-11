SetsPosition = Ember.Mixin.create
	
	setPosition: ->
		if @block.children.length > 0
			@blockPosition = @block.children.lastObject.blockPosition + 1
		else
			@blockPosition = 0

`export default SetsPosition`