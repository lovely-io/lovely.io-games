#
# The reset buton unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Smile extends Element
  constructor: ->
    super 'div', class: 'smile'

    @removeClass = @removeClass.bind(@)

    @on 'click', 'fire', 'reset'

  reset: ->
    @setClass('smile')

  blink: ->
    @addClass('blink')
    @removeClass.delay(400, 'blink')

  fail: ->
    @addClass('fail')

  done: ->
    @addClass('done')