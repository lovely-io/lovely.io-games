#
# Represents the mines field unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Field extends Element
  size_x:       0
  size_y:       0

  density:      0

  opened_cells: 0
  marked_cells: 0
  rigged_cells: 0
  total_cells:  0

  populated:    false

  #
  # Constructor
  #
  # @param {String} x-y sizes
  # @param {Integer} cells per mine factor
  # @return {Field} this
  #
  constructor: (size, density)->
    super 'div', class: 'field'

    size = size.split('x')

    @size_x = size[0].toInt()
    @size_y = size[1].toInt()

    @total_cells  = @size_x * @size_y
    @rigged_cells = (@total_cells / density).floor()

    @build()

    @on mark: @mark, open: @open

  #
  # Builds the field structure
  #
  # @return void
  #
  build: ->
    @cells = new List()

    for y in [0..@size_y-1]
      row = new Element('div').insertTo(@)

      for x in [0..@size_x-1]
        @cells.push(new Cell(x,y).insertTo(row))

    return # void


  #
  # Resets the field state
  #
  # @return void
  #
  reset: ->
    @opened_cells = 0
    @marked_cells = 0

    @populated    = false

    @cells.forEach('reset')

  #
  # Marks a cell as rigged
  #
  # @param {dom.Event} event
  # @return void
  #
  mark: (event)->
    @marked_cells += if event.target.marked then 1 else -1
    @check();
    return # void

  #
  # Tries to open up a cell
  #
  # @param {dom.Event} event
  # @return void
  #
  open: (event)->
    cell = event.target

    @populate(cell) unless @populated
    @neighbors(cell).forEach('open') if cell.mines is 0

    @opened_cells +=1
    @check()

    return # void

  #
  # Blows up the field when the player made a mistake
  #
  # @return void
  #
  blow: ->
    @cells.forEach (cell)->
      unless cell.opened
        if cell.marked && !cell.rigged
          cell.addClass('wrong')
        else if cell.rigged && !cell.marked
          cell.addClass('rigged')

    return # void

# protected

  # Checks if the field is fully opened
  check: ->
    if @marked_cells is @rigged_cells
      if (@opened_cells + @marked_cells) is @total_cells
        @emit('done')

    return # void

  # populates the field with mines starting from the given cell
  populate: (cell)->
    neighbors = @neighbors(cell)

    candidates = @cells.filter (c)->
      c isnt cell and neighbors.indexOf(c) is -1

    candidates.shuffle().slice(0, @rigged_cells).forEach (cell)->
      cell.rigged = true
      @neighbors(cell).forEach('addMine')
    , this

    @populated = true

  # finds a list of the cell neigbour cells
  neighbors: (cell)->
    result = new List()

    for i in [0..8]
      x = cell.pos_x + (i % 3)         - 1
      y = cell.pos_y + (i / 3).floor() - 1

      if x > -1 && y > -1 && x < @size_x && y < @size_y
        unless x is cell.pos_x && y is cell.pos_y
          result.push(@cells[y * @size_x + x])

    return result