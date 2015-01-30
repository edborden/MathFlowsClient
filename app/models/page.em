attr = DS.attr

class Page extends DS.Model
	layout: DS.belongsTo 'layout'
	document: DS.belongsTo 'document'
	pdfLink: ~> @document.pdfLink
	number: ~> @document.pages.indexOf(@) + 1

	+volatile
	questionPositionsSorted: -> @positions.filterBy('blockQuestion').sortBy 'row','col'

	isPage:true
	positions: DS.hasMany 'position'

	loadedPositions:false
	posNumber: 0

	+observer positions
	onPositionChange: ->
		unless @loadedPositions
			if @positions.length > @posNumber
				@stablePositions = Ember.A []
				@stablePositions.addObjects @positions
				@loadedPositions = true

	stablePositions: null

	reloadOtherDocuments: ->
		otherDocuments = @document.flow.documents.filter (document) => document isnt @document
		otherDocuments.forEach (document) -> document.reload()

`export default Page`