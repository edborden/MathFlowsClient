`import IsResizable from 'math-flows-client/mixins/is-resizable'`

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service
observer = Ember.observer

class BlockImageComponent extends Ember.Component with IsResizable

	# ATTRIBUTES

	image: null
	preview: null
	attributeBindings: ['style']

	# SERVICES

	modeler: service()

	# COMPUTED

	block: alias 'image.block'
	height: alias 'image.height'
	width: alias 'image.width'
	alignment: alias 'image.alignment.side'
	style: Ember.computed "height","width","alignment", ->
		"height:#{@height}px;width:#{@width}px;float:#{@alignment}".htmlSafe()
	src: Ember.computed -> "http://res.cloudinary.com/hmb9zxcjb/image/upload/#{@image.cloudinaryId}".htmlSafe()

	# RESIZABLE

	resizeHandles: "all"
	resizeAspectRatio: true
	containmentId: Ember.computed -> "#" + Ember.$(@element).parents(".grid-stack-item").attr 'id'

	onResize: (e,ui) ->
		@width = ui.size.width
		@height = ui.size.height
		@modeler.saveModel(@image).then => 
			@block.validate() if @block.contentInvalid # image is constrained, cannot be resized bigger than containment el

	onBlockInvalidation: observer 'block.contentInvalid', ->
		if @block.contentInvalid
			Ember.$(@element).resizable {containment:false}
		else
			Ember.$(@element).resizable {containment:@containmentId}

`export default BlockImageComponent`