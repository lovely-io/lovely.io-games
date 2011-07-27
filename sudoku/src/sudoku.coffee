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

    @field = new Field().insertTo(@)

    @reset()

  #
  # Resets the game
  #
  # @return {Sudoku} game
  #
  reset: ->
    @puzzle = new Puzzle(@options.level)

    @field.reset(@puzzle)

    return @


