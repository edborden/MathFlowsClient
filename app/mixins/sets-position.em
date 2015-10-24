SetsPosition = Ember.Mixin.create
  
  setPosition: ->
    unless @block.children.length == 1
      @blockPosition = @block.children.lastObject.blockPosition + 1
    else
      @blockPosition = 0

`export default SetsPosition`