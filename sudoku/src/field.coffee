#
# Implements the sudoku game field element
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Field extends Element

  constructor: ->
    @$super 'div', class: 'field'
    @insert '123456789'.split('').map (i)->
      new Block()

    return @