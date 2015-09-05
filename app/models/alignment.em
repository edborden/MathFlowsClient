`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Alignment extends DS.Model with ModelName

	# ATTRIBUTES

	side: attr()

	# COMPUTED

	left: ~> @side is "left"
	right: ~> @side is "right"

`export default Alignment`