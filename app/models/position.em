attr = DS.attr

class Position extends DS.Model

	#owner: DS.belongsTo 'owner', {polymorphic:true}
	#positionable: DS.belongsTo 'positionable', {polymorphic:true}
	row: attr "number"
	col: attr "number"
	rowSpan: attr "number"
	colSpan: attr "number"

	block: DS.belongsTo 'block', {inverse:null}
	snippet: DS.belongsTo 'snippet', {inverse:null}
	page: DS.belongsTo 'page', {inverse:null}

	positionable: ~> @block or @snippet

	width: attr "number"
	height: attr "number"
	colWidth: attr "number"

`export default Position`