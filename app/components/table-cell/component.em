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
	block: Ember.computed.alias 'cell.table.block'

	cell: Ember.computed -> @row.cells.filterBy('col', @col).firstObject or @createCell @row,@col

	createCell: (row,col) ->
		cell = @store.createRecord 'cell', {row:@row,col:@col,table:@row.table}
		line = @store.createRecord 'line', {cell:cell,position:0}
		cell.lines.addObject line
		line.cell = cell
		@row.cells.pushObject cell
		@col.cells.pushObject cell
		cell.row = @row
		cell.col = @col
		return cell

	# RESIZE OPTIONS

	alsoResizeId: Ember.computed.alias 'col.renderer'
	containmentId: Ember.computed -> "#" + Ember.$(@element).parents(".grid-stack-item").attr 'id' 
	resizeHandles: 'e'

	onResize: (event,ui) ->
		oldWidth = @col.size
		newWidth = ui.size.width
		gotBigger = oldWidth < newWidth
		gotSmaller = not gotBigger

		@col.size = ui.size.width
		Ember.$(@element).css 'width', ''
		@modeler.saveModel(@col).then => 
			@block.validate() if (@block.contentInvalid and gotSmaller) or (gotBigger and not @block.contentInvalid)		

	##

	contextMenu: -> 
		@menuOpen = true unless @preview
		false

	focusOut: ->
		@send 'closeMenu'

	actions:
		closeMenu: -> @menuOpen = false

`export default TableCellComponent`