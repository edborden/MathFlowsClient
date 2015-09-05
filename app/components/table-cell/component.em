`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`

class TableCellComponent extends Ember.Component with HandlesEquations

	tagName: 'td'

	store: Ember.inject.service()
	modeler: Ember.inject.service()

	row: null
	col: null
	preview: null
	menuOpen: false

	cell: ~> @row.cells.filterBy('col', @col).firstObject or @createCell @row,@col

	parentId: -> 
		el = Ember.$(@element).parents(".grid-stack-item").attr 'id'
		"#" + el 
	
	createCell: (row,col) ->
		cell = @store.createRecord 'cell', {row:@row,col:@col,table:@row.table,content:""}
		@row.cells.pushObject cell
		@col.cells.pushObject cell
		cell.row = @row
		cell.col = @col
		return cell

	didInsertElement: ->
		@colResizeInit()

	willDestroyElement: ->
		@colResizeDestroy()

	colResizeDestroy: ->
		Ember.$(@element).resizable "destroy"

	colResizeInit: ->
		onResize = Ember.run.bind @, @onResize
		unless @preview
			Ember.$(@element).resizable
				handles: 'e'
				stop: onResize
				containment: @parentId()
				alsoResize: @col.renderer

	onResize: (event,ui) ->
		@col.size = ui.size.width
		@modeler.saveModel @col
		Ember.$(@element).css 'width', ''

	contextMenu: -> 
		@menuOpen = true unless @preview
		false

	focusOut: ->
		@send 'closeMenu'

	actions:
		closeMenu: -> @menuOpen = false

`export default TableCellComponent`