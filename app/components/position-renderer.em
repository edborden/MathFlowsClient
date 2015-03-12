`import ElRegister from 'math-flows-client/mixins/el-register'`
`import Notify from 'ember-notify'`

class PositionRendererComponent extends Ember.Component with ElRegister

	classNames: ['position-renderer']
	tagName: 'li'
	position: null
	page: ~> @position.page
	block: ~> @position.block

	doubleClick: -> 
		Ember.$(@element).focus()
		@isEditing = true
	focusOut: -> @isEditing = false

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col','tabindex']
	"data-sizex": ~> @position.colSpan
	"data-sizey": ~> @position.rowSpan
	"data-row": ~> @position.row
	"data-col": ~> @position.col
	tabindex: 0

	gridster: ~> @parentView.gridster

	coords: ~> @gridster.dom_to_coords Ember.$(@element)

	didInsertElement: ->
		@_super()
		if @position.isNew
			@addToGrid()
			@syncAttrsToEl().then => 
				@page.reloadOtherDocuments()
				@page.document.refreshQuestionNumbers()
				
	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			@position.colSpan = $(@element).attr('data-sizex')
			@position.rowSpan = $(@element).attr('data-sizey')
			@position.row = $(@element).attr('data-row')
			@position.col = $(@element).attr('data-col')
			@position.save().then -> resolve()

	addToGrid: -> @gridster.add_widget @element,parseInt(@position.colSpan),parseInt(@position.rowSpan)

	deleteBlock: 'deleteBlock'
	toggleNumber: 'toggleNumber'
	deleteImage: 'deleteImage'
	addImage: 'addImage'
	openGraphModal: 'openGraphModal'
	actions:
		deleteBlock: ->
			@sendAction 'deleteBlock',@position.block
		deleteImage: ->
			@sendAction 'deleteImage',@position.block
		toggleNumber: ->
			@sendAction 'toggleNumber',@position.block
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',sources:['local', 'url',],show_powered_by:false}, (error, result) => 
				@sendAction 'addImage',
					block: @position.block
					cloudinaryId: result[0].public_id
					width: result[0].width
					height: result[0].height
		openGraphModal: ->
			@sendAction 'openGraphModal',@position.block
		setEquationContainerHeight: (height) -> @equationContainerHeight = height

	equationContainerHeight: 0
	availableImageHeight: ~> @position.height - @equationContainerHeight
	availableImageWidth: ~> @position.width

`export default PositionRendererComponent`