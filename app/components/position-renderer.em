`import ElRegister from 'math-flows-client/mixins/el-register'`

class PositionRendererComponent extends Ember.Component with ElRegister

	classNames: ['position-renderer']
	tagName: 'li'
	page: ~> @position.page

	isEditing: false
	action: "editPosition"
	doubleClick: -> 
		Ember.$(@element).focus()
		@isEditing = true
	focusOut: -> @isEditing = false

	filePickerInput: ~> Ember.$(@element).children('.file-picker')

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
		@filePickerInput.hide()
		if @position.isNew
			@addToGrid()
			@syncAttrsToEl().then => 
				@page.reloadOtherDocuments()
				@page.document.refreshQuestionNumbers()
		@filePickerInput.on 'change', @readFile.bind(this)

	willDestroyElement: ->
		@filePickerInput.off 'change', @readFile.bind(this)
				
	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			@position.colSpan = $(@element).attr('data-sizex')
			@position.rowSpan = $(@element).attr('data-sizey')
			@position.row = $(@element).attr('data-row')
			@position.col = $(@element).attr('data-col')
			@position.save().then -> resolve()

	addToGrid: -> @gridster.add_widget @element,parseInt(@position.colSpan),parseInt(@position.rowSpan)

	deleteBlock: 'deleteBlock'
	addNumber: 'addNumber'
	deleteNumber: 'deleteNumber'
	addImage: 'addImage'
	openGraphModal: 'openGraphModal'
	actions:
		deleteBlock: ->
			@sendAction 'deleteBlock',@position.block
		addNumber: ->
			@sendAction 'addNumber',@position.block
		deleteNumber: ->
			@sendAction 'deleteNumber',@position.block
		fileLoaded: (file) ->
			file.block = @position.block
			@sendAction 'addImage',file
		openFileDialog: ->
			@filePickerInput.click()
		openGraphModal: ->
			@sendAction 'openGraphModal',@position.block

	readFile: (event) ->
		file = event.target.files[0]
		reader = new FileReader()

		reader.onload = (event) =>
			@send 'fileLoaded',
				type: file.type
				binary: event.target.result
				size: file.size

		reader.readAsDataURL file

`export default PositionRendererComponent`