#
# Project's main unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Sudoku extends Element
  level: null

  #
  # Basic constructor
  #
  # @param {String} difficulty
  # @return {Sudoku} new game
  #
  constructor: (level)->
    super 'div', class: 'sudoku'

    @level = Cookie.get('sudoku-level') || level || 'normal'

    @field   = new Field().insertTo(@)
    @status  = new Status().insertTo(@)
    @records = new Records().insertTo(@)

    @on 'reset', @reset

    @reset()

  #
  # Resets the game
  #
  # @return {Sudoku} game
  #
  reset: (event)->
    if event && event.level
      Cookie.set('sudoku-level', @level = event.level)

    @puzzle = new Puzzle(@level)

    @field.reset(@puzzle)
    @status.reset(@puzzle)
    @records.reset(@puzzle)

    return @


