`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed
alias = computed.alias
equal = computed.equal
service = Ember.inject.service
observer = Ember.observer

class Block extends DS.Model with ModelName

  server: service()

  ## ATTRIBUTES

  row: attr "number"
  col: attr "number"
  rowSpan: attr "number"
  colSpan: attr "number"
  width: attr "number"
  height: attr "number"
  x: attr "number"
  y: attr "number" #not used
  kind: attr "string"
  contentInvalid: attr "boolean"
  renderer: null

  ## ASSOCIATIONS

  page: belongsTo 'page', {async:false}
  images: hasMany 'image', {async:false}
  tables: hasMany 'table', {async:false}
  lines: hasMany 'line', {async:false}

  ## COMPUTED

  children: computed 'images','tables', ->
    childrenFlat = []
    [@images,@tables].forEach (childArray) -> childrenFlat.pushObjects childArray.toArray()
    childrenFlat.sortBy 'blockPosition'
  pageNumber: alias 'page.number'
  question: equal 'kind','question'
  header: equal 'kind','header'
  questionBlocksSorted: alias 'page.questionBlocksSorted'
  sortedLines: computed 'lines', -> @lines.sortBy 'position'

  removeFromPage: ->
    @page = null
    @row = null
    @col = null

  ## QUESTION NUMBER

  questionNumber: computed 'questionBlocksSorted', -> 
    @questionBlocksSorted.indexOf(@) + 1 if @page and @question

  questionNumberWidth: computed 'question','questionNumber', ->
    questionNumberWidth = if @question
      if @questionNumber < 10
        17
      else if @questionNumber < 100
        27
      else
        37
    else
      0
    questionNumberWidth.toString()

  ## INVALIDATIONS

  invalid: computed -> @contentInvalid or @positionInvalid()
  positionInvalid: -> @row + @rowSpan > 27

  validate: -> 
    if @id? and @row? and @col?
      @server.post('blocks/' + @id + '/validate').then =>
        @notifyPropertyChange 'invalid'
        @page.notifyPropertyChange 'invalidBlocks' if @page

`export default Block`