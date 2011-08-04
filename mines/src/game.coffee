#
# The main class of the system, basically a front-controller
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Game extends Element
  include: core.Options

  extend:
    Options:
      size:    '10x10' # x-y field size
      density: 6       # cells per mine factor

  #
  # Basic constructor
  #
  # @param {Object} options override
  # @return {Game} this
  #
  constructor: (options)->
    super 'div', class: 'mines-game'

    @setOptions(options)

    @append(
      @timer = new Timer()
      @stats = new Stats()
      @smile = new Smile()
      @field = new Field(@options.size, @options.density)
      new Element('h2', html: "Hiscores")
      @score = new Hiscore(key: 'mines-game', reverse: true))

    @on
      fail:  @fail
      mark:  @mark
      open:  @open
      done:  @done
      reset: @reset

    @reset()

  #
  # Resets the game
  #
  # @return {Game} this
  #
  reset: ->
    @field.reset()
    @smile.reset()
    @timer.reset()

    @mark()

    return @

# protected

  fail: ->
    @timer.stop()
    @smile.fail()
    @field.blow()

    return # void

  done: ->
    @timer.stop()
    @smile.done()
    @score.add(@timer.text())

    return # void

  mark: ->
    @stats.update(
      @field.marked_cells,
      @field.rigged_cells)
    return # void

  open: ->
    @smile.blink()

    return # void