# Timer

Timer is a simple timer widget

    :javascript
    Lovely(["timer"], function(Timer) {
      var timer = new Timer();
      timer.insertTo('#some .element');

      timer.start();
      timer.stop();
      timer.reset();
    });

## Options

There are several additional options you can use when creating a timer element

 * `hours` - if you need it to show the hours counter (default `false`)
 * `milli` - if you need it to show milliseconds counter (default `false`)
 * `period` - the update calls period in milliseconds (default `1000`)

## HTML Structure

Timer is basically a very simple `DIV` element with the `timer` css-class

    :html
    <div class="timer">00:00</div>

But it also gets assigned the `active` css-class when it's working


## Copyright And License

This project is released under the terms of the MIT license

Copyright (C) 2011 Nikolay Nemshilov