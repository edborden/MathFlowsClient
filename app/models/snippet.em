attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	block: DS.belongsTo 'block'
	equation: attr()
	image: attr()

`export default Snippet`