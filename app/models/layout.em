attr = DS.attr

class Layout extends DS.Model

	pageCols: attr "number"
	pageRowHeight: attr "number"
	pageColWidth: attr "number"
	pageWidth: attr "number"
	pageHeight: attr "number"
	pageOutsideMargin: attr "number"
	pageInsideMargin: attr "number"
	blockCols: attr "number"
	blockRowHeight: attr "number"

	gridsterOutsideMargin: ~> @pageOutsideMargin - @gridsterInsideMargin
	gridsterInsideMargin: ~> @pageInsideMargin / 2

`export default Layout`