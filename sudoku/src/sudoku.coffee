#
# Project's main unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Sudoku extends Element
  include: core.Options,

  extend:
    Options:
      level: 'normal'

  #
  # Basic constructor
  #
  # @param {Object} options
  # @return {Sudoku} new game
  #
  constructor: (options)->
    @setOptions(options)
    options = Hash.reject(options, (key)-> key of Hiscore.Options)
    @$super('div', options).addClass('sudoku')
    @on('mousedown': @_mousedown, 'mouseover': @_mouseover, 'mouseout': @_mouseout)

    @field = new Field().insertTo(@)

    # presetting the cell ids for quick navigation
    @cells = []
    for cell, i in @find('.cell')
      cell.id = i
      pos = @_cell_pos(cell)
      @cells[pos.x] or= []
      @cells[pos.x][pos.y] = cell

    @reset()

  #
  # Resets the game
  #
  # @return {Sudoku} game
  #
  reset: ->
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
        @cells[i][pos.y]._.className =
        @cells[pos.x][i]._.className =
        'cell hover'


  _mouseout:  (event)->
    if event.target instanceof Cell
      pos = @_cell_pos(event.target)

      for i in [0..8]
        @cells[i][pos.y]._.className =
        @cells[pos.x][i]._.className =
        'cell'


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