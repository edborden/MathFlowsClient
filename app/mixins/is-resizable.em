IsResizable = Ember.Mixin.create

	didInsertElement: ->
		@resizeInit() unless @preview

	willDestroyElement: ->
		@resizeDestroy() unless @preview

	resizeDestroy: ->
		Ember.$(@element).resizable "destroy" if Ember.$(@element).resizable "instance"

	resizeInit: ->
		onResize = Ember.run.bind @, @onResize
		Ember.$(@element).resizable
			handles: @resizeHandles
			stop: onResize
			containment: @containmentId
			alsoResize: @alsoResizeId
			aspectRatio: @resizeAspectRatio

`export default IsResizable`