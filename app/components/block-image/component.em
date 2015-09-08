`import IsResizable from 'math-flows-client/mixins/is-resizable'`

class BlockImageComponent extends Ember.Component with IsResizable

	modeler: Ember.inject.service()
	image: null
	preview: null
	attributeBindings: ['style']

	style: ~> "height:#{@image.height}px;width:#{@image.width}px;float:#{@image.alignment.side}".htmlSafe()
	src: ~> "http://res.cloudinary.com/hmb9zxcjb/image/upload/" + @image.cloudinaryId

	# RESIZABLE OPTIONS

	resizeHandles: "all"
	onResize: (e,ui) ->
		@image.width = ui.size.width
		@image.height = ui.size.height
		@modeler.saveModel @image
	resizeAspectRatio: true
	containmentId: (-> 
		el = Ember.$(@element).parents(".grid-stack-item").attr 'id'
		"#" + el 
	).property()

`export default BlockImageComponent`