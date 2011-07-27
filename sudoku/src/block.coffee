#
# Implements a 3x3 cells block
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Block extends Element

  constructor: ->
    @$super 'div', class: 'block'

    @insert '123456789'.split('').map (i)->
      new Cell()
