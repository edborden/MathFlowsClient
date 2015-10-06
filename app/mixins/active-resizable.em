run = Ember.run
bind = run.bind

ActiveResizable = Ember.Mixin.create

	goActive: ->
		super()
		@resizeInit()

	goInactive: ->
		super()
		@resizeDestroy()

`export default ActiveResizable`