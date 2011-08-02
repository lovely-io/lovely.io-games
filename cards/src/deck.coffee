#
# Implements a simple cards deck unit
#
# Copyright (C) 2011
#
class Deck extends Element
  type: null # the deck's size (not the number of cards left)

  #
  # Basic constructor
  #
  # @param {Integer} deck size (36|52|54)
  # @return {Deck} this
  #
  constructor: (type)->
    super 'div', class: "deck"
    @type = type

    return @reset()


  #
  # Makes a new collection of the cards in the deck
  #
  # NOTE: looses any leftovers!
  #
  # @return {Deck} this
  #
  reset: ->
    @clear()

    switch ~~@type
      when 36 then type = '6' # short deck
      when 52 then type = '2' # full deck without jockers
      else         type = '0' # full deck with two jockers

    for rank of Card.RANKS
      if rank >= type
        for suit of Card.SUITS
          @insert(new Card(rank, suit))

    if type is '0'
      @insert(new Card('Jocker', 'black'))
      @insert(new Card('Jocker', 'red'))

    return @


  #
  # Returns the list of all cards in the deck
  #
  # @return {dom.Search} cards list
  #
  cards: ->
    @find('div.card')

  #
  # Shuffles the cards in the deck
  #
  # @return {Deck} this
  #
  shuffle: ->
    for i in [0..@cards().length * 4]
      @insert(@random())

    return @

  #
  # Returns a random card out of the deck
  #
  # @return {Card} card
  #
  random: ->
    cards = @cards()
    cards[~~(Math.random() * cards.length)]