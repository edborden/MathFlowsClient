ActiveResizable = Ember.Mixin.create

  goActive: ->
    super()
    @resizeInit()

  goInactive: ->
    super()
    @resizeDestroy()

`export default ActiveResizable`