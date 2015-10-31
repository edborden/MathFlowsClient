`import IsResizable from 'math-flows-client/mixins/is-resizable'`
`import ActiveItem from 'math-flows-client/mixins/active-item'`
`import ActiveNew from 'math-flows-client/mixins/active-new'`

computed = Ember.computed
alias = computed.alias
observer = Ember.observer

`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class BlockImageComponent extends Ember.Component with IsResizable,ActiveItem,ActiveNew

  # ATTRIBUTES

  image: null
  preview: null
  attributeBindings: ['style']

  # COMPUTED

  model: alias 'image'
  block: alias 'image.block'
  height: alias 'image.height'
  width: alias 'image.width'
  alignment: alias 'image.alignment.side'
  style: computed "height","width","alignment", ->
    "height:#{@height}px;width:#{@width}px;float:#{@alignment}".htmlSafe()
  src: computed -> "https://res.cloudinary.com/hmb9zxcjb/image/upload/#{@image.cloudinaryId}".htmlSafe()
  invalid: alias 'block.contentInvalid'

  # RESIZABLE

  resizeHandles: "s,se"
  resizeAspectRatio: true
  containmentId: computed 'invalid', -> 
    if @invalid then false else "#" + Ember.$(@element).parents(".grid-stack-item").attr 'id'

  onResize: (e,ui) ->
    @width = ui.size.width
    @height = ui.size.height
    saveModel(@image).then => 
      @block.validate() if @block.contentInvalid # image is constrained, cannot be resized bigger than containment el

  onBlockInvalidation: observer 'invalid', ->
    Ember.$(@element).resizable "option", "containment", @containmentId if @active
        
`export default BlockImageComponent`