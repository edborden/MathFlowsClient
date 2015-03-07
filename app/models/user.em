attr = DS.attr

class User extends DS.Model
	layout: DS.belongsTo 'layout'
	name: attr()
	pic: attr()
	folders: DS.hasMany 'folder'
	stableFolders: ~> @folders.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	topFolders: ~> @stableFolders.rejectBy 'folder'
	guest: attr()
	headers: DS.hasMany 'position'
	group: DS.belongsTo 'group'

	## TEMPORARY FIX FOR EMBER DATA WONKINESS. HAS_MANY RELATIONSHIPS RELOAD ON ANY CHANGE CAUSING VIEWS TO RE-RENDER, BREAKING GRIDSTER.
	stableHeaders: null

	loadedHeaders:false

	+observer headers
	onHeadersChange: ->
		unless @loadedHeaders
			if @headers.length > 0
				@stableHeaders = Ember.A []
				@stableHeaders.addObjects @headers
				@loadedHeaders = true
	##

`export default User`