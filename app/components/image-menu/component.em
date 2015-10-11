`import modeler from 'math-flows-client/utils/modeler'`
destroyModel = modeler.destroyModel

class ImageMenuComponent extends Ember.Component

  # ATTRIBUTES

  image: null

  # ACTIONS

  actions:
    destroyImage: -> 
      @setActiveItem null
      destroyModel @image

`export default ImageMenuComponent`