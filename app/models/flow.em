attr = DS.attr

class Flow extends DS.Model

	documents: DS.hasMany 'document'
	layout: DS.belongsTo 'layout'
	user: DS.belongsTo 'user'

`export default Flow`