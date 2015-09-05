`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Image extends DS.Model with ModelName

	# ATTRIBUTES

	height: attr "number"
	width: attr "number"
	cloudinaryId: attr()

	# ASSOCIATIONS

	block: belongsTo 'block', {async:false}
	alignment: belongsTo 'alignment', { async:false }

`export default Image`