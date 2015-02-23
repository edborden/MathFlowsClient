attr = DS.attr

class Image extends DS.Model
	block: DS.belongsTo 'block'
	binary: attr()
	height: attr "number"
	width: attr "number"
	type: attr()
	size: attr()

`export default Image`