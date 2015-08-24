`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Page extends DS.Model with ModelName
	test: belongsTo 'test', {async:false}
	blocks: hasMany 'block', {async:false}

	#HELPERS

	number: ~> @testIndex + 1
	testIndex: (-> @test.pages.indexOf @).property 'test.pages.[]'
	firstPage: ~> @number is 1
	lastPage: (-> @test.pages.lastObject is @).property 'test.pages.[]'
	previousPage: (-> @test.pages.objectAt(@testIndex - 1)).property 'test.pages.[]'
	nextPage: (-> @test.pages.objectAt(@testIndex + 1)).property 'test.pages.[]'
				
`export default Page`