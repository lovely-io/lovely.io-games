#
# Project's main unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Timer extends Element
  include: core.Options

  extend:
    # default options
    Options:
      hours:  false # show the hours counter
      milli:  false # show the milliseconds
      period: 1000  # update period

  #
  # Basic constructor
  #
  # @param {Object} options
  #
  constructor: (options)->
    @setOptions(options)
    options = Hash.reject(options, (key)-> key of Timer.Options)
    super('div', options)
    @addClass('timer').reset()

    global.setInterval(bind(@update, @), @options.period)

    return @

  #
  # Resets the timer
  #
  # @return {Timer} this
  #
  reset: ->
    @time    = new Date()
    @active  = false

    @removeClass('active').update(true)

  #
  # Starts/resumes the timer
  #
  # @return {Timer} this
  #
  start: ->
    @active = true
    @time   = new Date()

    @addClass('active')

  #
  # Stops/pauses the timer
  #
  # @return {Timer} this
  #
  stop: ->
    @active = false

    @update(true).removeClass('active')

  #
  # Updates the timer visible data
  #
  # @param {Boolean} forced update
  # @return {Timer} this
  #
  update: (force)->
    return @ unless @active || force

    time    = new Date() - @time

    seconds = Math.floor(time / 1000)
    minutes = Math.floor(seconds / 60)
    hours   = Math.floor(minutes / 60)

    seconds = seconds % 60
    minutes = minutes % 60
    time    = time    % 1000

    seconds = "0#{seconds}" if seconds < 10
    minutes = "0#{minutes}" if minutes < 10
    hours   = "0#{hours}"   if hours   < 10
    time    = "0#{time}"    if time    < 100
    time    = "0#{time}"    if time.length < 3

    html    = "#{minutes}:#{seconds}"
    html    = "#{hours}:#{html}" if @options.hours
    html    = "#{html}.#{time}"  if @options.milli

    @_.innerHTML = html
    return @