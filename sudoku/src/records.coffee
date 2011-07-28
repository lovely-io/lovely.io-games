#
# The game records block
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Records extends Element

  constructor: ->
    super 'div', class: 'records'

    new Element('h3', html: 'Hiscores').insertTo(@)
    @hiscore = new Hiscore(size: 8).insertTo(@)

    return @

  reset: (puzzle)->
    @hiscore.options.key = "sudoku-#{puzzle.level}"
    @hiscore.rebuild()

    return @