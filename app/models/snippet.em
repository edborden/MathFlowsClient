attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	block: DS.belongsTo 'block'
	equation: attr 'boolean'

`export default Snippet`