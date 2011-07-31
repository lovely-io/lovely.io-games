#
# Implements a simple cards deck unit
#
# Copyright (C) 2011
#
class Deck extends Element
  extend:
    SIZE: [
      'full'
    ]

  cards: null # the list of cards

  #
  # Basic constructor
  #
  # @param {String} cards size
  # @return {Deck} this
  #
  constructor: (size)->
    super 'div', class: "deck"

    @cards = new List()

    for rank of Card.RANKS
      for suit of Card.SUITS
        @cards.push(new Card(rank, suit, size))

    return @


  #
  # Shuffles the cards in the deck
  #
  # @return {Deck} this
  #
  shuffle: ->
    return @