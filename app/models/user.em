`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class User extends DS.Model with ModelName
	name: attr()
	pic: attr()
	premium: attr 'boolean'
	folders: hasMany 'folder', {inverse: 'user'}
	topTestFolders: ~> @folders.rejectBy('folder').filterBy 'testFolder'
	topStudentFolders: ~> @folders.rejectBy('folder').filterBy 'studentFolder'
	guest: attr()
	blocks: hasMany 'block'
	group: belongsTo 'group'

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