#
# Represents the timer block in the left top corner
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Timer extends Element

  constructor: ->
    super 'div', class: 'timer'
    @update.bind(@).periodical(1000)

  reset: ->
    @stamp   = new Date()
    @stopped = false
    @update()

  stop: ->
    @stopped = true

  update: ->
    this.$super(@time()) unless @stopped

  time: ->
    seconds = ((new Date() - @stamp)/1000).round()
    minutes = (seconds / 60).floor()
    seconds = seconds % 60

    seconds = [minutes, seconds].map (num)->
      (if num < 10 then '0' else '') + num

    seconds.join(':')