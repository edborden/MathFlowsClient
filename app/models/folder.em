attr = DS.attr

class Folder extends DS.Model

	user: DS.belongsTo 'user', {inverse: 'folders'}
	flows: DS.hasMany 'flows'
	stableFlows: ~> @flows.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	name: attr()
	open: attr "boolean"
	isFolder: true
	folder: DS.belongsTo 'folder', {inverse: 'folders'}
	folders: DS.hasMany 'folder', {inverse: 'folder'}
	stableFolders: ~> @folders.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666

`export default Folder`