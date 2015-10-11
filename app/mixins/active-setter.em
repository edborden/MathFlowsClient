ActiveSetter = Ember.Mixin.create

  activeItem: null
  activeItemRenderer: null
  
  actions:
    setActiveItem: (item,renderer) ->
      unless @activeItem is item
        @activeItemRenderer.goInactive() if @activeItemRenderer? and @activeItemRenderer.goInactive?
        @activeItem = item
        @activeItemRenderer = renderer
        @activeItemRenderer.goActive() if @activeItemRenderer? and @activeItemRenderer.goActive?

`export default ActiveSetter`