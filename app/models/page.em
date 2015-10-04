`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias
equal = computed.equal

class Page extends DS.Model with ModelName
	test: belongsTo 'test', {async:false}
	blocks: hasMany 'block', {async:false}

	#HELPERS

	pages: alias 'test.pages'
	number: computed 'testIndex', -> @testIndex + 1
	testIndex: computed 'pages.[]', -> @pages.indexOf @
	firstPage: equal 'number', 1
	lastPage: computed 'pages.[]', -> @pages.lastObject is @
	previousPage: computed 'pages.[]', -> @pages.objectAt(@testIndex - 1)
	nextPage: computed 'pages.[]', -> @pages.objectAt(@testIndex + 1)
				
`export default Page`