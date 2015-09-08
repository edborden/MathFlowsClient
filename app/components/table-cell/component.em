`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`
`import IsResizable from 'math-flows-client/mixins/is-resizable'`

class TableCellComponent extends Ember.Component with HandlesEquations,IsResizable

	tagName: 'td'

	store: Ember.inject.service()
	modeler: Ember.inject.service()

	row: null
	col: null
	preview: null
	menuOpen: false

	cell: ~> @row.cells.filterBy('col', @col).firstObject or @createCell @row,@col

	createCell: (row,col) ->
		cell = @store.createRecord 'cell', {row:@row,col:@col,table:@row.table,content:""}
		@row.cells.pushObject cell
		@col.cells.pushObject cell
		cell.row = @row
		cell.col = @col
		return cell

	# RESIZE OPTIONS

	alsoResizeId: ~> @col.renderer
	containmentId: (-> 
		el = Ember.$(@element).parents(".grid-stack-item").attr 'id'
		"#" + el 
	).property()
	resizeHandles: 'e'

	onResize: (event,ui) ->
		@col.size = ui.size.width
		@modeler.saveModel @col
		Ember.$(@element).css 'width', ''

	##

	contextMenu: -> 
		@menuOpen = true unless @preview
		false

	focusOut: ->
		@send 'closeMenu'

	actions:
		closeMenu: -> @menuOpen = false

`export default TableCellComponent`