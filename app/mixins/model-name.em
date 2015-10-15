computed = Ember.computed

ModelName = Ember.Mixin.create

  init: ->
    @_super()
    name = "is#{@modelName}"
    @set name,true

  modelName: computed -> @modelKey.capitalize()

  modelKey: computed -> @toString().split(":")[1]

`export default ModelName`