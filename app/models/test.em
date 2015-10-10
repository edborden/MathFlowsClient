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
	pages: hasMany 'page', {async:false}
	name: attr()
	folder: belongsTo 'folder', {async:false}

	## COMPUTED

	pdfLink: computed 'session.token', -> config.apiHostName+'/tests/'+@id+'.pdf?token='+@session.token
	multiplePages: computed 'pages.length', -> @pages.length > 1
	blocks: hasMany 'block', {async:false}

	## INVALID BLOCKS

	invalidBlocks: computed -> @blocks.filterBy 'invalid'
	invalid: computed 'invalidBlocks.length', -> @invalidBlocks.length isnt 0

	## QUESTION NUMBERS

	refreshQuestionNumbers: -> @notifyPropertyChange 'questionBlocksSorted'
	questionBlocksSorted: computed 'blocks.length', -> @blocks.filterBy('question').sortBy 'pageNumber','row','col'
		
`export default Test`