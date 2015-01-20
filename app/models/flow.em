attr = DS.attr

class Flow extends DS.Model

	documents: DS.hasMany 'document'
	layout: DS.belongsTo 'layout'
	folder: DS.belongsTo 'folder'
	name: attr()

`export default Flow`