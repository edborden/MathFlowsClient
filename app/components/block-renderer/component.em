`import ElRegister from 'math-flows-client/mixins/el-register'`
`import Notify from 'ember-notify'`

class BlockRendererComponent extends Ember.Component with ElRegister

	classNames: ['block-renderer']
	tagName: 'li'
	block: null
	page: ~> @block.page

	doubleClick: -> 
		Ember.$(@element).focus()
		@isEditing = true
	focusOut: -> @isEditing = false

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col','tabindex']
	"data-sizex": ~> @block.colSpan
	"data-sizey": ~> @block.rowSpan
	"data-row": ~> @block.row
	"data-col": ~> @block.col
	tabindex: 0

	gridster: ~> @parentView.gridster

	coords: ~> @gridster.dom_to_coords Ember.$(@element)

	didInsertElement: ->
		@_super()
		if @block.isNew
			@addToGrid()
			@syncAttrsToEl()
				
	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			@block.colSpan = parseInt $(@element).attr('data-sizex')
			@block.rowSpan = parseInt $(@element).attr('data-sizey')
			@block.row = parseInt $(@element).attr('data-row')
			@block.col = $(@element).attr('data-col')
			@block.save().then -> resolve()

	addToGrid: -> @gridster.add_widget @element,parseInt(@block.colSpan),parseInt(@block.rowSpan)

	deleteBlock: 'deleteBlock'
	toggleNumber: 'toggleNumber'
	deleteImage: 'deleteImage'
	addImage: 'addImage'
	openGraphModal: 'openGraphModal'
	actions:
		deleteBlock: ->
			@sendAction 'deleteBlock',@block
		deleteImage: ->
			@sendAction 'deleteImage',@block
		toggleNumber: ->
			@sendAction 'toggleNumber',@block
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',sources:['local', 'url',],show_powered_by:false}, (error, result) => 
				@sendAction 'addImage',
					block: @block
					cloudinaryId: result[0].public_id
					width: result[0].width
					height: result[0].height
		openGraphModal: ->
			@sendAction 'openGraphModal',@block
		setEquationContainerHeight: (height) -> @equationContainerHeight = height

	equationContainerHeight: 0
	availableImageHeight: ~> @block.height - @equationContainerHeight
	availableImageWidth: ~> @block.width

`export default BlockRendererComponent`