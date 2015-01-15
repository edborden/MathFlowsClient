attr = DS.attr

class Block extends DS.Model
	
	childPositions: DS.hasMany 'position', {inverse:null}
	layout: DS.belongsTo 'layout'

`export default Block`