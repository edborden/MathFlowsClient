`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Layout extends DS.Model

	blocks: DS.hasMany 'block'
	pdfLink: ~> config.apiHostName+'/layouts/'+@id+'?token='+@session.token

`export default Layout`