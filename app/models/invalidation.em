`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Invalidation extends DS.Model with ModelName
	block: belongsTo 'block', {async:false}
	messageType: attr "number"
	

`export default Invalidation`