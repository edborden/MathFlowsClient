attr = DS.attr

class Page extends DS.Model
	layout: DS.belongsTo 'layout'
	document: DS.belongsTo 'document'
	pdfLink: ~> @document.pdfLink
	number: ~> @document.pages.indexOf(@) + 1

	positions: DS.hasMany 'position'

	reloadOtherDocuments: ->
		otherDocuments = @document.flow.documents.filter (document) => document isnt @document
		otherDocuments.forEach (document) -> 
			document.reload().then (document) -> 
				document.pages.forEach (page) ->
					page.syncStablePositions()

	refreshQuestionNumbers: ->
		@stablePositions.forEach (position) -> position.notifyPropertyChange 'questionNumber'

	## TEMPORARY FIX FOR EMBER DATA WONKINESS. HAS_MANY RELATIONSHIPS RELOAD ON ANY CHANGE CAUSING VIEWS TO RE-RENDER, BREAKING GRIDSTER.
	stablePositions: null

	loadedPositions:false

	+observer positions
	onPositionChange: ->
		unless @loadedPositions
			if @positions.length > 0
				@stablePositions = Ember.A []
				@stablePositions.addObjects @positions
				@loadedPositions = true

	syncStablePositions: ->
		@positions.forEach (position) =>
			@stablePositions.addObject position unless @stablePositions.contains position
	##
`export default Page`