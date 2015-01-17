attr = DS.attr

class Page extends DS.Model

	blocks: DS.hasMany 'block'
	document: DS.belongsTo 'document'
	layout: DS.belongsTo 'layout'
	pdfLink: ~> @document.pdfLink
	children: ~> @blocks
	number: ~> @document.pages.indexOf(@) + 1

`export default Page`