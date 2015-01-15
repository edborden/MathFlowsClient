attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	equation: attr()
	image: attr()
	position: DS.belongsTo 'position'

`export default Snippet`