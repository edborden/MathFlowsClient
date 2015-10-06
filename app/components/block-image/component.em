`import IsResizable from 'math-flows-client/mixins/is-resizable'`
`import ActiveItem from 'math-flows-client/mixins/active-item'`
`import ActiveResizable from 'math-flows-client/mixins/active-resizable'`

computed = Ember.computed
alias = computed.alias
observer = Ember.observer

`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class BlockImageComponent extends Ember.Component with IsResizable,ActiveItem,ActiveResizable

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
	src: computed -> "http://res.cloudinary.com/hmb9zxcjb/image/upload/#{@image.cloudinaryId}".htmlSafe()

	# RESIZABLE

	resizeHandles: "se,sw"
	resizeAspectRatio: true
	containmentId: computed -> "#" + Ember.$(@element).parents(".grid-stack-item").attr 'id'

	onResize: (e,ui) ->
		@width = ui.size.width
		@height = ui.size.height
		saveModel(@image).then => 
			@block.validate() if @block.contentInvalid # image is constrained, cannot be resized bigger than containment el

	onBlockInvalidation: observer 'block.contentInvalid', ->
		if @block.contentInvalid
			Ember.$(@element).resizable {containment:false}
		else
			Ember.$(@element).resizable {containment:@containmentId}

`export default BlockImageComponent`