attr = DS.attr

class Page extends DS.Model
	layout: DS.belongsTo 'layout'
	document: DS.belongsTo 'document'
	pdfLink: ~> @document.pdfLink
	number: ~> @document.pages.indexOf(@) + 1

	isPage:true
	positions: DS.hasMany 'position'

	loadedPositions:false

	+observer positions
	onPositionChange: ->
		unless @loadedPositions
			if @positions.length > 0
				@stablePositions = Ember.A []
				@stablePositions.addObjects @positions
				@loadedPositions = true

	refreshQuestionNumbers: ->
		@stablePositions.forEach (position) -> position.notifyPropertyChange 'questionNumber'

	stablePositions: null

	syncStablePositions: ->
		@positions.forEach (position) =>
			@stablePositions.addObject position unless @stablePositions.contains position

	reloadOtherDocuments: ->
		otherDocuments = @document.flow.documents.filter (document) => document isnt @document
		otherDocuments.forEach (document) -> 
			document.reload().then (document) -> 
				document.pages.forEach (page) ->
					page.syncStablePositions()

`export default Page`