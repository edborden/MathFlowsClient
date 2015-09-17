`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Line extends DS.Model with ModelName
	content: attr "string", {defaultValue:""}
	block: belongsTo 'block', {async:false}
	cell: belongsTo 'cell', {async:false}
	position: attr "number"
	styles: hasMany 'style', {async:false}

	stylesCSS: (-> 
		@styles.getEach("css").join("").htmlSafe()
	).property "styles.[]"

	effects: (->
		@styles.getEach "effect"
	).property "styles.[]"

	bold: Ember.computed "effects", -> @effects.contains "bold"
	italic: Ember.computed "effects", -> @effects.contains "italic"
	underline: Ember.computed "effects", -> @effects.contains "underline"
	red: Ember.computed "effects", -> @effects.contains "red"

	## RENDERED ELEMENT
	renderer: null

`export default Line`