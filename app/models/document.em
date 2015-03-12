`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Document extends DS.Model

	iconName: "fa-file-text-o"
	pages: DS.hasMany 'page'
	stablePages: ~> @pages.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	flow: DS.belongsTo 'flow'
	pdfLink: ~> config.apiHostName+'/documents/'+@id+'.pdf?token='+@session.token
	layout: ~> @flow.layout
	multiplePages: ~> @stablePages.length > 1
	name: attr()
	copyFrom: DS.belongsTo 'document'
	isDocument: true

	refreshQuestionNumbers: ->
		@notifyPropertyChange 'questionPositionsSorted'
		@stablePages.forEach (page) -> page.refreshQuestionNumbers()

	questionPositionsSorted: ~> 
		allPositions = @stablePages.getEach 'stablePositions'
		allPositionsFlat = [].concat.apply [], allPositions
		questionPositionsSorted = allPositionsFlat.filterBy('questionBlock').sortBy 'pageNumber','row','col'
		
`export default Document`