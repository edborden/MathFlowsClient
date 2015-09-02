`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Projection extends DS.Model with ModelName

	## ATTRIBUTES

	axis: attr()
	position: attr "number"
	size: attr "number"

	## ASSOCIATIONS

	table: belongsTo 'table', {async:false}
	cells: hasMany 'cells', { async:false }

	## COMPUTED

	row: ~> @axis is "row"
	col: ~> @axis is "col"

`export default Projection`