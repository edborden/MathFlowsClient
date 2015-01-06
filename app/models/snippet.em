attr = DS.attr

class Snippet extends DS.Model
	content: attr()
	block: DS.belongsTo 'block'
	equation: attr()
	equationFormatted: ~> "data:image/png;base64," + @equation

`export default Snippet`