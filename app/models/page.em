`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias
equal = computed.equal

class Page extends DS.Model with ModelName
	test: belongsTo 'test', {async:true}
	blocks: hasMany 'block', {async:false}

	#HELPERS

	pages: alias 'test.pages'
	number: computed 'testIndex', -> @testIndex + 1
	testIndex: computed 'pages.[]', -> @pages.indexOf @
	firstPage: equal 'number', 1
	lastPage: computed 'pages.[]', -> @pages.lastObject is @
	previousPage: computed 'pages.[]', -> @pages.objectAt(@testIndex - 1)
	nextPage: computed 'pages.[]', -> @pages.objectAt(@testIndex + 1)

	## QUESTION NUMBERS

	refreshQuestionNumbers: -> @test.notifyPropertyChange 'questionBlocksSorted'
	questionBlocksSorted: alias 'test.questionBlocksSorted'

	## INVALID BLOCKS

	invalidBlocks: computed -> @blocks.filterBy 'invalid'
	invalid: computed 'invalidBlocks.length', -> @invalidBlocks.length isnt 0
				
`export default Page`