`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Line extends DS.Model with ModelName
	content: attr()
	block: belongsTo 'block'
	position: attr "number"

	## RENDERED ELEMENT
	renderer: null
				
`export default Line`