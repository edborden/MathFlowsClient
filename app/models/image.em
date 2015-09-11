`import ModelName from 'math-flows-client/mixins/model-name'`
`import SetsPosition from 'math-flows-client/mixins/sets-position'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Image extends DS.Model with ModelName,SetsPosition

	# ATTRIBUTES

	height: attr "number"
	width: attr "number"
	cloudinaryId: attr()
	blockPosition: attr "number"

	# ASSOCIATIONS

	block: belongsTo 'block', {async:false}
	alignment: belongsTo 'alignment', { async:false }

`export default Image`