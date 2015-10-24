`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed

class Line extends DS.Model with ModelName
  content: attr "string", {defaultValue:""}
  block: belongsTo 'block', {async:false}
  cell: belongsTo 'cell', {async:false}
  position: attr "number"
  styles: hasMany 'style', {async:false}

  stylesCSS: computed "styles.[]", -> 
    @styles.getEach("css").join("").htmlSafe()

  effects: computed "styles.[]", ->
    @styles.getEach "effect"

  bold: computed "effects", -> @effects.contains "bold"
  italic: computed "effects", -> @effects.contains "italic"
  underline: computed "effects", -> @effects.contains "underline"
  red: computed "effects", -> @effects.contains "red"

  ## RENDERED ELEMENT
  renderer: null

`export default Line`