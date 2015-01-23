attr = DS.attr

class Page extends DS.Model

	blocks: DS.hasMany 'block'
	document: DS.belongsTo 'document'
	layout: DS.belongsTo 'layout'
	pdfLink: ~> @document.pdfLink
	number: ~> @document.pages.indexOf(@) + 1
	questionBlocks: ~>
		@blocks.filterBy 'question',true
	isPage:true

`export default Page`