`import GridEditorComponent from 'math-flows-client/components/grid-editor'`

class BlockEditorComponent extends GridEditorComponent

	grid: null
	widgets: ~> @grid.stableSnippets 
	widgetRendererTemplate: "components/snippet-renderer" 
	action: "editSnippet"
	registerAction: 'registerEditor'

	position: ~> @grid.positions.firstObject

	cols: ~> @grid.layout.blockCols
	widgetMargin: ~> 0
	widgetBaseWidth: ~> @position.colWidth
	widgetBaseHeight: ~> @grid.layout.blockRowHeight
	height: ~> @position.height
	width: ~> @position.width
	padding: ~> 0

	didInsertElement: ->
		@sendAction 'registerAction',@
		@_super()

`export default BlockEditorComponent`