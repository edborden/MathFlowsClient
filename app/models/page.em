attr = DS.attr

class Page extends DS.Model

	childPositions: DS.hasMany 'position'
	document: DS.belongsTo 'document'
	layout: DS.belongsTo 'layout'

`export default Page`