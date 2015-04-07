attr = DS.attr

class User extends DS.Model
	name: attr()
	pic: attr()
	premium: attr 'boolean'
	folders: DS.hasMany 'folder', {inverse: 'user'}
	topTestFolders: ~> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: ~> @folders.rejectBy('folder').filterBy 'studentFolder'
	guest: attr()
	blocks: DS.hasMany 'block'
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