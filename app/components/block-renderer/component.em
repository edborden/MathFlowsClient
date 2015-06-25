class BlockRendererComponent extends Ember.Component
	store: Ember.inject.service()
	modaler:Ember.inject.service()
	modeler:Ember.inject.service()

	gridster:null
	block:null

	tagName: 'li'
	classNameBindings: ["invalid","active","static"]
	classNames: ["gs-w"]

	willDestroyElement: -> @removeFromGrid()

	active:false
	blockBeingDragged: false

	static: ~> if @active then false else !@blockBeingDragged
	invalid: ~> @block.invalid

	click: -> 
		Ember.$(@element).focus()
		@active = true
	focusOut: -> @active = false

	attributeBindings: ['tabindex']
	tabindex: 0

	coords: -> @gridster.dom_to_coords Ember.$(@element)

	didInsertElement: ->
		@parent.on 'syncIfOutOfSync', @, @syncAttrsToEl
		@addToGrid()
		isNew = @block.isNew
		if @block.hasDirtyAttributes
			@addToGrid()
			@syncAttrsToEl()
			if isNew
				Ember.$(@element).find(".content").mousedown().mouseup()
				
	syncAttrsToEl: ->
		console.log @block.colSpan,@coords().size_x,@block.rowSpan,@coords().size_y,@block.row,@coords().row,@block.col,@coords().col
		@block.colSpan = @coords().size_x
		@block.rowSpan = @coords().size_y
		@block.row = @coords().row
		@block.col = @coords().col
		@modeler.saveModel @block
		@refreshQuestionNumbers()

	addToGrid: -> @gridster.add_widget @element,@block.colSpan,@block.rowSpan,@block.col,@block.row

	actions:
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
		setBlockActive: -> @active = true

	availableImageHeight: ~> @block.height - @block.linesHeight
	availableImageWidth: ~> @block.width

	+observer block.isDeleted
	isDeleted: -> 
		if @block.isDeleted
			@removeFromGrid()
			@refreshQuestionNumbers()

	removeFromGrid: -> @gridster.remove_widget @element,true

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test

`export default BlockRendererComponent`