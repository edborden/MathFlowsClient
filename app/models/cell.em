`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Cell extends DS.Model with ModelName

	## ATTRIBUTES

	content: attr()

	## ASSOCIATIONS

	table: belongsTo 'table', {async:false}
	row: belongsTo 'projection', {async:false}
	col: belongsTo 'projection', {async:false}
	lines: hasMany 'line', {async:false}

`export default Cell`