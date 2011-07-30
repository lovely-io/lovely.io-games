#
# Implements the sudoku game field element
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Field extends Element

  #
  # Builds the field structure
  #
  # @return {Field} this
  #
  constructor: ->
    @$super 'div', class: 'field'
    @insert '123456789'.split('').map (i)->
      new Block()

    # presetting the cell ids for quick navigation
    @cells = []
    for cell, i in @find('.cell')
      cell.id = i
      pos = @_cell_pos(cell)
      @cells[pos.x] or= []
      @cells[pos.x][pos.y] = cell

    @popup = new Popup().insertTo(@)

    @on 'mousedown', @_mousedown
    @on 'mouseover', @_mouseover
    @on 'mouseout',  @_mouseout
    @on 'mark',      @_mark

    return @

  #
  # Fills in the field with a new puzzle
  #
  # @param {Puzzle} puzzle map
  # @return {Field} this
  #
  reset: (puzzle)->
    for row, x in puzzle
      for value, y in row
        @cells[x][y].value(value)

    return @


# protected

  # triggers the numbers popup to show over the cell
  _mousedown: (event)->
    if event.target instanceof Cell and event.target.parent().parent() is @
      unless event.target.hasClass('preset')
        @_mouseout(event)
        @popup.showAt(event.target)

    return # nothing


  # highlights the cross
  _mouseover: (event)->
    if event.target instanceof Cell and event.target.parent().parent() is @
      event.target.addClass('hover')

      pos = @_cell_pos(event.target)

      for i in [0..8]
        @cells[i][pos.y]._.className += ' cross'
        @cells[pos.x][i]._.className += ' cross'

    return # nothing


  # removes the cross-highlightning
  _mouseout: (event)->
    if event.target instanceof Cell and event.target.parent().parent() is @
      event.target.removeClass('hover')

      pos = @_cell_pos(event.target)

      for i in [0..8]
        @cells[i][pos.y]._.className = @cells[i][pos.y]._.className.replace(' cross', '')
        @cells[pos.x][i]._.className = @cells[pos.x][i]._.className.replace(' cross', '')

    return # nothing


  # validates the value on a cell marking
  _mark: (event)->
    pos   = @_cell_pos(event.target)
    cells = event.target.parent().find('.cell') # block cells

    for i in [0..8]
      cells.push(@cells[i][pos.y])
      cells.push(@cells[pos.x][i])

    for cell in cells
      if cell isnt event.target and cell.value() is event.value
        return event.target.duplicate(true)

    event.target.duplicate(false)

    # checking if the field is fully covered
    for row, y in @cells
      for cell, x in row
        if cell.empty or cell.error
          return cell

    @emit('over')


  # converts cell's ID into its x-y position on the field
  _cell_pos: (cell)->
    cell_id = cell.id

    box_id  = Math.floor(cell_id / 9)
    box_y   = Math.floor(box_id / 3)
    box_x   = box_id % 3

    cell_id = cell_id % 9
    cell_x  = box_x * 3 + cell_id % 3
    cell_y  = box_y * 3 + Math.floor(cell_id / 3)

    {x: cell_x, y: cell_y}