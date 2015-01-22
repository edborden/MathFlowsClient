`import GridEditorComponent from 'math-flows-client/components/grid-editor'`

class PageEditorComponent extends GridEditorComponent

	grid: null
	widgets: ~> @grid.snippets 
	widgetRendererTemplate: "components/snippet-renderer" 
	action: "editSnippet"
	registerAction: 'registerEditor'

	cols: ~> @grid.layout.blockCols
	widgetMargin: ~> 0
	widgetBaseWidth: ~> @grid.colWidth
	widgetBaseHeight: ~> @grid.layout.blockRowHeight
	height: ~> @grid.height
	width: ~> @grid.width
	padding: ~> 0

	didInsertElement: ->
		@sendAction 'registerAction',@
		@_super()

`export default PageEditorComponent`