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

	+volatile
	questionBlocksSorted: -> 
		questionPositionsSorted = @pages.getEach 'questionPositionsSorted'
		questionPositionsSorted = [].concat.apply [], questionPositionsSorted
		console.log questionPositionsSorted.length
		questionPositionsSorted.getEach 'block'

`export default Document`