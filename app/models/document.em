`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Document extends DS.Model

	pages: DS.hasMany 'page'
	flow: DS.belongsTo 'flow'
	pdfLink: ~> config.apiHostName+'/documents/'+@id+'.pdf?token='+@session.token
	layout: ~> @flow.layout
	multiplePages: ~> @pages.length > 1
	number: ~> @flow.documents.indexOf(@) + 1
	name: ~> "Version " + @number
	copyFrom: DS.belongsTo 'document'

	refreshQuestionNumbers: ->
		@notifyPropertyChange 'questionPositionsSorted'
		@pages.forEach (page) -> page.refreshQuestionNumbers()

	questionPositionsSorted: ~> 
		allPositions = @pages.getEach 'stablePositions'
		allPositionsFlat = [].concat.apply [], allPositions
		questionPositionsSorted = allPositionsFlat.filterBy('questionBlock').sortBy 'pageNumber','row','col'
		
`export default Document`