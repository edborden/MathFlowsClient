`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo

class Image extends DS.Model with ModelName
	block: belongsTo 'block'
	height: attr "number"
	width: attr "number"
	scale: attr "number", {defaultValue:5}
	cloudinaryId: attr()

`export default Image`