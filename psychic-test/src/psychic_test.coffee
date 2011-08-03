#
# Project's main unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class PsychicTest extends Element

  #
  # Basic constructor
  #
  # @return {PsychicTest} this
  #
  constructor: ->
    super 'div', class: 'psychic-test'

    @append(
      @deck     = new Deck(36),
      @controls = new Controls(),
      new Element('h2', html: 'Hiscores'),
      @hiscore  = new Hiscore(key: 'psychic-test'))

    @on 'pick', @_pick

    return @reset()

  #
  # Resets the game
  #
  # @return {PsychicTest} this
  #
  reset: ->
    @deck.reset()
    @controls.reset()
    @card = @deck.random().insertTo(@deck, 'after')

    return @

  #
  # Shows the next card
  #
  # @return {PsychicTest} this
  #
  next: ->
    if @deck.cards().length > 1
      @card.replace(@card = @deck.random())
    else
      @hiscore.add(@controls.result())

    return @

# protected

  # color pick handler
  _pick: (event)->
    return if @card.opened()

    @controls.count(@card.color() == event.color)
    @card.open()
    setTimeout(bind(@next, @), 1000)

