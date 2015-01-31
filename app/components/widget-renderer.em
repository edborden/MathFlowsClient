`import ElRegister from 'math-flows-client/mixins/el-register'`

class WidgetRendererComponent extends Ember.Component with ElRegister

	tagName: 'li'

	doubleClick: -> 
		@sendAction 'action',@widget

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col']
	"data-sizex": ~> @widget.colSpan
	"data-sizey": ~> @widget.rowSpan
	"data-row": ~> @widget.row
	"data-col": ~> @widget.col

	gridster: ~> @parentView.gridster

	coords: ~> @gridster.dom_to_coords Ember.$(@element)

	didInsertElement: ->
		@_super()
		if @widget.isNew
			@addToGrid()
			@syncAttrsToEl().then => @grid.reloadOtherDocuments() if @grid.isPage
				
	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			@widget.colSpan = $(@element).attr('data-sizex')
			@widget.rowSpan = $(@element).attr('data-sizey')
			@widget.row = $(@element).attr('data-row')
			@widget.col = $(@element).attr('data-col')
			@widget.save().then -> resolve()

	addToGrid: -> @gridster.add_widget @element,parseInt(@widget.colSpan),parseInt(@widget.rowSpan)

`export default WidgetRendererComponent`