# Cards

Cards is a simple [lovely.io](http://lovely.io) package that
provides a reusable playing cards feature


## API Reference

Basically, this module provides two classes, `Card` and `Deck`, both
are inherited from from the `dom.Element` unit, so the usage is pretty
much straight forward

    :javascript
    Lovely(["cards"], function(cards) {
      var deck = new cards.Deck();
      var card = deck.first();

      card instanceof cards.Card; // -> true
    });

Besides inherited `dom` methods there are some additional methods for
each of the classes.

 * `Card#open([true_false])` - open / close the card
 * `Card#opened()` - checks if the card is open
 * `Card#flip()` - flips the current card state
 * `Card#color()` - returns the color of the card ('red' or 'black')
 * `Deck#reset()` - fills the deck with a new set of cards
 * `Deck#cards()` - returns `dom.Search` with all the cards in the deck
 * `Deck#shuffle()` - shuffles the deck in a random order
 * `Deck#random()` - returns a random card out of the deck

The `Deck` class constructor also can make a number argument of `36`, `52` or `54`
if you need to specify which type of deck do you need. By default it's a full `54`
cards deck.


## HTML/CSS Structure

HTML/CSS structure is rather a bit complicated to be described in here,
but you should know that instances of `Card` and `Deck` units automatically
get assigned the `card` and `deck` css-classes respectively, so you can
refer them in your scripts/styles as you like.



## Copyright And License

This project is released under the terms of the MIT license

Copyright (C) 2011 Nikolay Nemshilov