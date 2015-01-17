`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Document extends DS.Model

	pages: DS.hasMany 'page'
	flow: DS.belongsTo 'flow'
	pdfLink: ~> config.apiHostName+'/documents/'+@id+'?token='+@session.token
	layout: ~> @flow.layout
	multiplePages: ~> @pages.length > 1

`export default Document`