#
# Implements a single cell on the game field
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Cell extends Element
  id:    null # cell ID on the field (for navigation)
  val:   null # cell carried value
  empty: null # a marker if the cell is empty
  error: null # if cell is duplicated with some others

  #
  # Basic constructor
  #
  # @return {Cell} this
  #
  constructor: ->
    super('div', class: 'cell')

  #
  # Assigns the cell value
  #
  # @param {Number} value
  # @return {Cell} this
  #
  value: (value)->
    if arguments.length
      if @val = parseInt(value)
        @html(@val).setClass('cell preset')
        @empty = false
      else
        @html('&nbsp;').setClass('cell')
        @empty = true

      return @
    else
      @val


  #
  # Marks the cell with the value as an user input
  #
  # @param {Number} value
  # @return {Cell} this
  #
  mark: (value)->
    @empty = false
    @html(value).emit('mark', value: value)

  #
  # Marks the cell as a duplicative
  #
  # @param {Boolean} value
  # @return {Cell} this
  #
  duplicate: (value)->
    if @error = value
      @addClass('duplicate')
    else
      @removeClass('duplicate')