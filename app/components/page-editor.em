`import GridEditorComponent from 'math-flows-client/components/grid-editor'`

class PageEditorComponent extends GridEditorComponent

	grid: null
	widgets: ~> @grid.positions
	widgetRendererTemplate: "components/block-renderer"
	action: "editBlock"

	pageLayout: ~> @grid.layout

	cols: ~> @pageLayout.page_cols
	widgetMargin: ~> @pageLayout.gridsterInsideMargin
	widgetBaseWidth: ~> @pageLayout.pageColWidth
	widgetBaseHeight: ~> @pageLayout.pageRowHeight
	height: ~> @pageLayout.pageHeight
	width: ~> @pageLayout.pageWidth
	padding: ~> @pageLayout.gridsterOutsideMargin

`export default PageEditorComponent`