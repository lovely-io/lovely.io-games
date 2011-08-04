#
# A basic mine field cell element
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Cell extends Element
  opened: false
  rigged: false
  marked: false

  pos_x:  0
  pos_y:  0
  mines:  0

  #
  # Constructor
  #
  # @param {Integer} position x
  # @param {Integer} position y
  # @return {Cell} this
  #
  constructor: (pos_x, pos_y)->
    super 'div', class: 'cell'

    @pos_x = pos_x
    @pos_y = pos_y

    @on 'mousedown', (event)->
      if event.which is 1
        @open()
      else
        @mark()

      false

    @on 'contextmenu', 'stopEvent'


  #
  # Resets the cell's state
  #
  # @return {Cell} this
  #
  reset: ->
    @opened = false
    @rigged = false
    @marked = false

    @mines  = 0

    @clear().setClass('cell')

  #
  # Tries to defuse the cell
  #
  # @return void
  #
  open: ->
    unless @opened or @marked
      @opened = true

      if @rigged
        @addClass 'failed'
        @emit 'fail'
      else
        @addClass 'opened'
        @emit 'open'

  #
  # Marks the cell as rigged
  #
  # @return void
  #
  mark: ->
    unless @opened
      @toggleClass 'marked'
      @marked = @hasClass('marked')
      @emit 'mark'

  #
  # Increments a nearby mines counter
  #
  # @return void
  #
  addMine: ->
    @mines += 1
    @html(@mines)
    @addClass('with-'+ @mines + '-mines')
