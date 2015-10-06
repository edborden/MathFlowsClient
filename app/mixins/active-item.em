ActiveItem = Ember.Mixin.create

  active: false
  classNameBindings: ['active:active:inactive']
  click: ->
    unless @preview
      @setActiveItem @model,@
    false
  goActive: ->
    super()
    @active = true
  goInactive: ->
    super()
    @active = false

`export default ActiveItem`