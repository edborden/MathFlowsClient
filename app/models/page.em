`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Page extends DS.Model with ModelName
	test: belongsTo 'test', {async:false}
	number: ~> @test.pages.indexOf(@) + 1
	blocks: hasMany 'block', {async:false}
				
`export default Page`