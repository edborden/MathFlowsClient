ActiveItem = Ember.Mixin.create

  active: false
  classNameBindings: ['active:active:inactive']
  click: ->
    unless @preview
      @setActiveItem @model,@
    false
  goActive: ->
    @_super()
    @active = true
  goInactive: ->
    @_super()
    @active = false

`export default ActiveItem`