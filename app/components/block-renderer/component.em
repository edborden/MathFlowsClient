`import ElRegister from 'math-flows-client/mixins/el-register'`
`import Notify from 'ember-notify'`

class BlockRendererComponent extends Ember.Component with ElRegister
	store: Ember.inject.service()

	classNames: ['block-renderer']
	tagName: 'li'

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

	coords: -> @gridster.dom_to_coords Ember.$(@element)

	didInsertElement: ->
		@_super()
		if @block.isDirty
			@addToGrid()
			@syncAttrsToEl()
				
	syncAttrsToEl: ->
			@block.colSpan = @coords().size_x
			@block.rowSpan = @coords().size_y
			@block.row = @coords().row
			@block.col = @coords().col
			@sendAction 'saveModel',@block
			@block.test.refreshQuestionNumbers()

	addToGrid: -> @gridster.add_widget @element,@block.colSpan,@block.rowSpan

	syncIfOutOfSync: -> @syncAttrsToEl() if @outOfSync() and not @block.isDeleted
	outOfSync: -> @widthIsDiff() or @heightIsDiff() or @rowIsDiff() or @colIsDiff()

	widthIsDiff: -> @block.colSpan isnt @coords().size_x
	heightIsDiff: -> @block.rowSpan isnt @coords().size_y
	rowIsDiff: -> @block.row isnt @coords().row
	colIsDiff: -> @block.col isnt @coords().col

	destroyModel: 'destroyModel'
	openGraphModal: 'openGraphModal'
	saveModel: 'saveModel'
	syncChangedBlocks: 'syncChangedBlocks'
	actions:
		toggleNumber: ->
			@block.toggleProperty 'question'
			@sendAction 'saveModel',@block
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',sources:['local', 'url',],show_powered_by:false}, (error, result) => 
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: result[0].width
					height: result[0].height
				@sendAction 'saveModel', image
		openGraphModal: -> @sendAction 'openGraphModal',@block
		setEquationContainerHeight: (height) -> @equationContainerHeight = height
		saveModel: (model) -> @sendAction 'saveModel', model
		destroyModel: (model) -> @sendAction 'destroyModel',model
		cutBlock: (model) -> 
			@removeFromGrid()
			model.removeFromPage()
			model.test.notifyPropertyChange 'clipboard'
			@sendAction 'saveModel',model
			@block.test.refreshQuestionNumbers()

	equationContainerHeight: 0
	availableImageHeight: ~> @block.height - @equationContainerHeight
	availableImageWidth: ~> @block.width

	+observer block.isDeleted
	isDeleted: -> 
		if @block.isDeleted
			@removeFromGrid()
			@block.test.refreshQuestionNumbers()

	removeFromGrid: -> @gridster.remove_widget @element,true


`export default BlockRendererComponent`