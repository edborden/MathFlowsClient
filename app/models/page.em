`import ModelName from 'math-flows-client/mixins/model-name'`
`import HasBlocks from 'math-flows-client/mixins/has-blocks'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Page extends DS.Model with ModelName,HasBlocks
	test: belongsTo 'test'
	pdfLink: ~> @test.pdfLink
	number: ~> @test.pages.indexOf(@) + 1
				
`export default Page`