attr = DS.attr

class Page extends DS.Model

	document: DS.belongsTo 'document'
	layout: DS.belongsTo 'layout'
	pdfLink: ~> @document.pdfLink
	number: ~> @document.pages.indexOf(@) + 1

	+volatile
	questionPositionsSorted: -> @positions.filterBy('blockQuestion').sortBy 'row','col'

	isPage:true
	positions: DS.hasMany 'position'

`export default Page`