# Hiscore

Hiscore is a little widget to create game leader boards

    :javascript
    Lovely(["hiscore"], function(Hiscore) {
      var hiscore = new Hiscore();
      hiscore.inserTo('#some .element');
      hiscore.add('12345');
    });

There is also couple of additional options available with the
constructor

 * `key` - cookie key (default `'hiscore'`)
 * `size` - the maximum number of records (default `10`)

Set the size to `null` if you don't want your leader board to be limited
by top several records.


## API Reference

Class `Hiscore` is inherited from `dom.Element` and has all the same API
plus some additional methods

 * `add(String result)` - registers a new score and prompts the user for a name
 * `clear()` - removes all the records from the list and cookies
 * `empty()` - checks if there are any records on the list
 * `rebuild()` - rebuilds the list from the data in cookies


## HTML Structore

Basically it's a simple `OL` list of records

    :html
    <ol class="hiscore">
      <li><span class="score">123</span><span class="name">Player 1</span></li>
      <li><span class="score">234</span><span class="name">Player 2</span></li>
      <li><span class="score">345</span><input type="text" value="Name" /></li>
    </ol>

Additionally the `OL` element receives the `empty` css class when there is no
records on the list.


## Copyright And License

This project is released under the terms of the MIT license

Copyright (C) 2011 Nikolay Nemshilov