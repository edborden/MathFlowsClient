`import IsResizable from 'math-flows-client/mixins/is-resizable'`

class BlockImageComponent extends Ember.Component with IsResizable

	modeler: Ember.inject.service()
	image: null
	block: Ember.computed.alias 'image.block'
	preview: null
	attributeBindings: ['style']

	style: ~> "height:#{@image.height}px;width:#{@image.width}px;float:#{@image.alignment.side}".htmlSafe()
	src: ~> "http://res.cloudinary.com/hmb9zxcjb/image/upload/" + @image.cloudinaryId

	# RESIZABLE OPTIONS

	resizeHandles: "all"

	onResize: (e,ui) ->
		@image.width = ui.size.width
		@image.height = ui.size.height
		@modeler.saveModel(@image).then => 
			@block.validate() if @block.contentInvalid # image is constrained, cannot be resized bigger than containment el

	resizeAspectRatio: true
	
	containmentId: Ember.computed -> "#" + Ember.$(@element).parents(".grid-stack-item").attr 'id'

	onBlockInvalidation: (->
		if @block.contentInvalid
			Ember.$(@element).resizable {containment:false}
		else
			Ember.$(@element).resizable {containment:@containmentId}
	).observes 'block.contentInvalid'

`export default BlockImageComponent`