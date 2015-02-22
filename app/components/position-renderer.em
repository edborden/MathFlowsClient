`import ElRegister from 'math-flows-client/mixins/el-register'`

class PositionRendererComponent extends Ember.Component with ElRegister

	isEditing: false

	classNames: ['position-renderer']

	layoutName: "components/block-renderer"
	tagName: 'li'

	page: ~> @position.page

	action: "editPosition"

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
	addNumber: 'addNumber'
	deleteNumber: 'deleteNumber'
	actions:
		deleteBlock: ->
			@sendAction 'deleteBlock',@position.block
		addNumber: ->
			@sendAction 'addNumber',@position.block
		deleteNumber: ->
			@sendAction 'deleteNumber',@position.block

`export default PositionRendererComponent`