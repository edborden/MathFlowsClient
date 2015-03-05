attr = DS.attr

class Image extends DS.Model
	block: DS.belongsTo 'block'
	height: attr "number"
	width: attr "number"
	scale: attr "number", {defaultValue:5}
	cloudinaryId: attr()

`export default Image`