`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`

class TableCellComponent extends Ember.Component with HandlesEquations

	tagName: 'td'

	store: Ember.inject.service()
	modeler: Ember.inject.service()

	row: null
	col: null
	preview: null

	cell: ~> @row.cells.filterBy('col', @col).firstObject or @createCell @row,@col

	parentId: -> 
		el = Ember.$(@element).parents(".grid-stack-item").attr 'id'
		"#" + el 
	
	createCell: (row,col) ->
		cell = @store.createRecord 'cell', {rowId:@row.id,colId:@col.id,tableId:@row.table.id,content:""}
		@row.cells.pushObject cell
		@col.cells.pushObject cell
		return cell

	didInsertElement: ->
		@colResizeInit()

	willDestroyElement: ->
		@colResizeDestroy()

	colResizeDestroy: ->
		Ember.$(@element).resizable "destroy"

	colResizeInit: ->
		console.log @col.renderer
		onResize = Ember.run.bind @, @onResize
		unless @preview
			Ember.$(@element).resizable
				handles: 'e'
				stop: onResize
				containment: @parentId()
				alsoResize: @col.renderer

	onResize: (event,ui) ->
		console.log ui.size.width
		@col.size = ui.size.width
		@modeler.saveModel @col
		Ember.$(@element).css 'width', ''

`export default TableCellComponent`