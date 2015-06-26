class BlockRendererComponent extends Ember.Component

	## SETUP

	store: Ember.inject.service()
	modaler:Ember.inject.service()
	modeler:Ember.inject.service()

	gridstack:null
	block:null

	attributeBindings: ["data-gs-no-resize","data-gs-no-move","tabindex"]
	classNameBindings: ["invalid","active"]
	classNames: ["grid-stack-item"]

	"data-gs-no-resize":true
	"data-gs-no-move":true
	tabindex:0

	active:false
	blockBeingDragged: false
	invalid: ~> @block.invalid

	availableImageHeight: ~> @block.height - @block.linesHeight
	availableImageWidth: ~> @block.width

	## EVENTS

	didInsertElement: ->
		@parent.on 'syncBlocks', @, @syncAttrsToEl
		Ember.run.next @,@addToGrid
		isNew = @block.isNew
		if @block.hasDirtyAttributes
			@syncAttrsToEl()
			if isNew
				Ember.$(@element).find(".content").mousedown().mouseup()

	+observer active
	onActiveChange: ->
		@gridstack.movable @element,@active
		@gridstack.resizable @element,@active

	willDestroyElement: -> @removeFromGrid()

	click: -> 
		Ember.$(@element).focus()
		@setBlockActive()
		
	focusOut: -> 
		@hideResizeHandle()
		@active = false

	+observer block.isDeleted
	isDeleted: -> 
		if @block.isDeleted
			@removeFromGrid()
			@refreshQuestionNumbers()

	## HELPERS

	showResizeHandle: ->
		handle = Ember.$(@element).find(".ui-resizable-handle")
		handle.show() if handle

	hideResizeHandle: ->
		handle = Ember.$(@element).find(".ui-resizable-handle")
		handle.hide()		

	coords: -> Ember.$(@element).data('_gridstack_node')

	syncAttrsToEl: ->
		coords = @coords()
		console.log coords.width,@block.colSpan,coords.height,@block.rowSpan
		@block.colSpan = coords.width
		@block.rowSpan = coords.height
		@block.row = coords.y
		@block.col = coords.x
		@modeler.saveModel @block
		@refreshQuestionNumbers()

	addToGrid: -> @gridstack.add_widget @element,@block.col,@block.row,@block.colSpan,@block.rowSpan

	removeFromGrid: -> @gridstack.remove_widget @element

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test

	setBlockActive: -> 
		@active = true
		@showResizeHandle()


	## ACTIONS

	actions:
		contentsClicked: ->
			@setBlockActive()
		toggleNumber: ->
			@block.toggleProperty 'question'
			@modeler.saveModel @block
			@refreshQuestionNumbers()
			@block.notifyPropertyChange 'width' #trigger width resize on equation box
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',show_powered_by:false}, (error, result) => 
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: result[0].width
					height: result[0].height
				@modeler.saveModel image
		openGraphModal: -> @modaler.openModal 'graph-modal',@block
		cutBlock: (model) -> 
			@removeFromGrid()
			model.removeFromPage()
			model.test.notifyPropertyChange 'clipboard'
			@modeler.saveModel model
			@refreshQuestionNumbers()
		copyBlock: (block) ->
			model = @store.createRecord 'block', {copyFromId:block.id}
			@modeler.saveModel model
		destroyModel: (model) ->
			@modeler.destroyModel model

`export default BlockRendererComponent`