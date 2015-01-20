attr = DS.attr

class Layout extends DS.Model

	in: ~> 1.5 * 72
	cols: attr "number"
	rowHeight: attr "number"
	colWidth: attr "number"
	width: attr "number"
	height: attr "number"
	outsideMargin: attr "number"
	insideMargin: attr "number"
	blockCols: attr "number"
	blockRowHeight: attr "number"
	gridsterOutsideMargin: ~> @outsideMargin - @gridsterInsideMargin
	gridsterInsideMargin: ~> @insideMargin / 2

`export default Layout`