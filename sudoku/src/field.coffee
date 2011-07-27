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

    @on('mousedown': @_mousedown, 'mouseover': @_mouseover, 'mouseout': @_mouseout)

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

  _mousedown: (event)->
    if event.target instanceof Cell
      pos = @_cell_pos(event.target)
      console.log("x:", pos.x, " y:", pos.y)

  _mouseover: (event)->
    if event.target instanceof Cell
      pos = @_cell_pos(event.target)

      for i in [0..8]
        @cells[i][pos.y]._.className += ' hover'
        @cells[pos.x][i]._.className += ' hover'


  _mouseout:  (event)->
    if event.target instanceof Cell
      pos = @_cell_pos(event.target)

      for i in [0..8]
        @cells[i][pos.y]._.className = @cells[i][pos.y]._.className.replace(' hover', '')
        @cells[pos.x][i]._.className = @cells[pos.x][i]._.className.replace(' hover', '')


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