#
# Implements a single cell on the game field
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Cell extends Element
  id:    null # cell ID on the field (for navigation)
  value: null # cell carried value

  constructor: ->
    super('div', class: 'cell')