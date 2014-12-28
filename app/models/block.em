attr = DS.attr

Block = DS.Model.extend
	col: attr "number"
	row: attr "number"
	width: attr "number"
	height: attr "number"
	content: attr()

`export default Block`