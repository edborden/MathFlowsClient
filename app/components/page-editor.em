`import GridEditorComponent from 'math-flows-client/components/grid-editor'`

class PageEditorComponent extends GridEditorComponent

	grid: null
	widgets: ~> @grid.positions
	widgetRendererTemplate: "components/block-renderer"
	action: "editBlock"

	cols: ~> @grid.layout.cols
	widgetMargin: ~> @grid.layout.gridsterInsideMargin
	widgetBaseWidth: ~> @grid.layout.colWidth
	widgetBaseHeight: ~> @grid.layout.rowHeight
	height: ~> @grid.layout.height
	width: ~> @grid.layout.width
	padding: ~> @grid.layout.gridsterOutsideMargin

`export default PageEditorComponent`