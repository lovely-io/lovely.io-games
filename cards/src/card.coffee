#
# Represents a single card unit
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Card extends Element
  extend:
    SUITS: # html codes for the suits
      clubs:    2663
      hearts:   2665
      spades:   2660
      diamonds: 2666

    RANKS: # the rank names
      2:  'Two'
      3:  'Three'
      4:  'Four'
      5:  'Five'
      6:  'Six'
      7:  'Seven'
      8:  'Eight'
      9:  'Nine'
      10: 'Ten'
      J:  'Jack'
      Q:  'Queen'
      K:  'King'
      A:  'Ace'

    SIZES: [ # available sizes
      'tiny'
      'small'
      'normal'
      'big'
    ]

    SIZE: 'normal' # default card-size


  # public attributes
  rank: null
  suit: null

  #
  # Basic constructor
  #
  # @param {String} rank
  # @param {String} suit
  # @return {Card} new
  #
  constructor: (rank, suit)->
    super 'div', class: "card card-#{Card.SIZE} card-#{rank} card-#{suit}"

    @rank = rank
    @suit = suit

    @append(
      @back = new Element('div', class: 'back'),
      @face = new Element('div', class: 'face'))

    @back.insert(new Element('div', class: 'decoration'))

    suit = "&#x#{Card.SUITS[suit]};"
    @face.append(
      new Element('div', class: 'decoration',  html: "<div class='picture'></div>"),
      new Element('div', class: 'name',        html: "#{rank}<div>#{suit}</div>"),
      new Element('div', class: 'name bottom', html: "#{rank}<div>#{suit}</div>"))

    if (dots = if /\d/.test(rank) then parseInt(rank) else if rank is 'A' then 1 else 0)
      for i in [0..dots-1]
        @face.insert(new Element('div', class: "dot dot-#{i+1}", html: suit))


    return @

  #
  # Opens (or hides if called with `false`) the card
  #
  # @param {Boolean} optional show/hide marker (`true` by default)
  # @return {Card} this
  #
  open: (open)->
    open = true if arguments.length is 0
    @[if open then 'addClass' else 'removeClass']('card-open')

  #
  # Check whether the card is opened or not
  #
  # @return {Boolean} check result
  #
  opened: ->
    @hasClass('card-open')

  #
  # Flips the card do the opposite state
  #
  # @return {Card} this
  #
  flip: ->
    @open(!@opened())

  #
  # Returns the color of the card
  #
  # @return {String} 'red' or 'black'
  #
  color: ->
    if @hasClass('card-spides') or @hasClass('card-clubs') or @hasClass('card-black')
      'black'
    else
      'red'