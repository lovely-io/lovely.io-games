#
# Shows the game stats block in the right top corner
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Stats extends Element

  constructor: ->
    super 'div', class: 'stats'

  update: (marked, total)->
    super marked + "/" + total