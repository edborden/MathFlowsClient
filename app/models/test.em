`import config from 'math-flows-client/config/environment'`
`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias

class Test extends DS.Model with ModelName

	session: Ember.inject.service()

	# ATTRIBUTES AND ASSOCIATIONS

	iconName: "fa-file-text-o"
	pages: hasMany 'page', {async:true}
	name: attr()
	folder: belongsTo 'folder', {async:false}

	## COMPUTED

	pdfLink: computed 'session.token', -> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token
	multiplePages: computed 'pages.length', -> @pages.length > 1

	questionBlocksSorted: computed 'pages.@each.blocks.length', -> 
		blocks = []
		@pages.getEach("blocks").forEach (blocksArray) -> blocks.pushObjects blocksArray.toArray()
		blocks.filterBy('question').sortBy 'pageNumber','row','col'

	## INVALID BLOCKS

	invalidPages: computed 'pages.@each.invalid', -> @pages.filterBy 'invalid'
	invalid: computed 'invalidPages.length', -> @invalidPages.length isnt 0

`export default Test`