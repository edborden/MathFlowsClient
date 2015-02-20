`import ElRegister from 'math-flows-client/mixins/el-register'`

class PositionRendererComponent extends Ember.Component with ElRegister

	layoutName: "components/block-renderer"
	tagName: 'li'

	page: ~> @position.page

	action: "editPosition"
	doubleClick: -> 
		@sendAction 'action',@position

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col']
	"data-sizex": ~> @position.colSpan
	"data-sizey": ~> @position.rowSpan
	"data-row": ~> @position.row
	"data-col": ~> @position.col

	gridster: ~> @parentView.gridster

	coords: ~> @gridster.dom_to_coords Ember.$(@element)

	didInsertElement: ->
		@_super()
		if @position.isNew
			@addToGrid()
			@syncAttrsToEl().then => @page.reloadOtherDocuments() if @page.isPage
				
	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			@position.colSpan = $(@element).attr('data-sizex')
			@position.rowSpan = $(@element).attr('data-sizey')
			@position.row = $(@element).attr('data-row')
			@position.col = $(@element).attr('data-col')
			@position.save().then -> resolve()

	addToGrid: -> @gridster.add_widget @element,parseInt(@position.colSpan),parseInt(@position.rowSpan)

`export default PositionRendererComponent`