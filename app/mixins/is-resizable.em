run = Ember.run
scheduleOnce = run.scheduleOnce
bind = run.bind

IsResizable = Ember.Mixin.create

	didInsertElement: ->
		scheduleOnce 'afterRender', @, 'resizeInit'

	willDestroyElement: ->
		@resizeDestroy()

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