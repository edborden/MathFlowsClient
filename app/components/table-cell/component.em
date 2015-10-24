`import IsResizable from 'math-flows-client/mixins/is-resizable'`
`import ActiveItem from 'math-flows-client/mixins/active-item'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

class TableCellComponent extends Ember.Component with IsResizable,ActiveItem

  # ATTRIBUTES

  tagName: 'td'
  row: null
  col: null
  preview: null

  # SERVICES

  store: service()

  # COMPUTED

  block: alias 'cell.table.block'
  cell: computed -> @row.cells.filterBy('col', @col).firstObject or @createCell @row,@col
  model: alias 'cell'

  createCell: (row,col) ->
    cell = @store.createRecord 'cell', {row:@row,col:@col,table:@row.table}
    line = @store.createRecord 'line', {cell:cell,position:0}
    cell.lines.addObject line
    line.cell = cell
    @row.cells.pushObject cell
    @col.cells.pushObject cell
    cell.row = @row
    cell.col = @col
    return cell

  # RESIZE OPTIONS

  alsoResizeId: computed -> Ember.$(@col.renderer).add(Ember.$(@element).parents('table'))
  containmentId: false#computed -> "#" + Ember.$(@element).parents(".grid-stack-item").attr 'id' 
  resizeHandles: 'e'

  onResize: (event,ui) ->
    oldWidth = @col.size
    newWidth = ui.size.width
    gotBigger = oldWidth < newWidth
    gotSmaller = not gotBigger

    @col.size = ui.size.width
    Ember.$(@element).css 'width', ''
    saveModel(@col).then => 
      @block.validate() if (@block.contentInvalid and gotSmaller) or (gotBigger and not @block.contentInvalid)

`export default TableCellComponent`