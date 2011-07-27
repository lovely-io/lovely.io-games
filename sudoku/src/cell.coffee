#
# Implements a single cell on the game field
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Cell extends Element
  id:    null # cell ID on the field (for navigation)
  value: null # cell carried value

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
    @html if @value = parseInt(value) then value else '&nbsp;'
