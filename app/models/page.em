attr = DS.attr

class Page extends DS.Model

	blocks: DS.hasMany 'block'
	document: DS.belongsTo 'document'
	layout: DS.belongsTo 'layout'
	pdfLink: ~> @document.pdfLink

`export default Page`