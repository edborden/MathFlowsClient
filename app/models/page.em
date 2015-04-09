`import Model from 'math-flows-client/lib/model'`

attr = DS.attr

class Page extends Model
	test: DS.belongsTo 'test'
	pdfLink: ~> @test.pdfLink
	number: ~> @test.pages.indexOf(@) + 1

	## TEMPORARY FIX FOR EMBER DATA WONKINESS. HAS_MANY RELATIONSHIPS RELOAD ON ANY CHANGE CAUSING VIEWS TO RE-RENDER, BREAKING GRIDSTER.
	blocks: DS.hasMany 'block'
	stableBlocks: null

	loadedBlocks:false

	+observer blocks
	onBlocksChange: ->
		unless @loadedBlocks
			if @blocks.length > 0
				@stableBlocks = Ember.A []
				@stableBlocks.addObjects @blocks
				@loadedBlocks = true
				
`export default Page`