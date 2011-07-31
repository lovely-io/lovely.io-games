#
# Implements a simple cards deck unit
#
# Copyright (C) 2011
#
class Deck extends Element

  #
  # Basic constructor
  #
  # @param {String} cards size
  # @return {Deck} this
  #
  constructor: (size)->
    super 'div', class: "deck"

    for rank of Card.RANKS
      for suit of Card.SUITS
        @insert(new Card(rank, suit, size))

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
    size = @cards().length

    for i in [0..size * 4]
      @insert(@cards()[~~(Math.random() * size)])

    return @