attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	equation: attr()
	image: attr()
	questionNumber: attr 'boolean'
	plainContent: ~> if @equation or @image or @questionNumber then false else true
	
	block: DS.belongsTo 'block'

	#position
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"
	x: (position) -> (@col-1)*position.colWidth
	y: attr "number"
	width: (position) -> @colSpan * position.colWidth
	height: attr "number"

`export default Snippet`