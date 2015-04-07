attr = DS.attr

class Page extends DS.Model
	test: DS.belongsTo 'test'
	pdfLink: ~> @test.pdfLink
	number: ~> @test.pages.indexOf(@) + 1

	blocks: DS.hasMany 'block'

	## TEMPORARY FIX FOR EMBER DATA WONKINESS. HAS_MANY RELATIONSHIPS RELOAD ON ANY CHANGE CAUSING VIEWS TO RE-RENDER, BREAKING GRIDSTER.
	stableBlocks: null

	loadedBlocks:false

	+observer blocks
	onBlocksChange: ->
		unless @loadedBlocks
			if @blocks.length > 0
				@stableBlocks = Ember.A []
				@stableBlocks.addObjects @blocks
				@loadedBlocks = true

	#syncStableBlocks: ->
	#	@blocks.forEach (block) =>
	#		@stableBlocks.addObject block unless @stableBlocks.contains block
	##
`export default Page`