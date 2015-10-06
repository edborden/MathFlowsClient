run = Ember.run
bind = run.bind

IsResizable = Ember.Mixin.create

	resizeDestroy: ->
		Ember.$(@element).resizable "destroy" if Ember.$(@element).resizable "instance" and not @preview

	resizeInit: ->
		unless @preview
			onResize = bind @, @onResize
			Ember.$(@element).resizable
				handles: @resizeHandles
				stop: onResize
				containment: @containmentId
				alsoResize: @alsoResizeId
				aspectRatio: @resizeAspectRatio

`export default IsResizable`