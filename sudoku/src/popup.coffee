#
# THe numbers menu popup
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Popup extends Element

  #
  # Basic constructor
  #
  # @return {Popup} this
  #
  constructor: ->
    super 'div', class: 'popup'

    @block = new Block().insertTo(@)

    @find('.cell').forEach (cell, i)->
      cell.value(i + 1)

    @on 'click', @_click

    $(global.document).on('click', bind(@hide, @))

    return @

  #
  # Shows the popup over the cell
  #
  # @param {Cell} anchor cell
  # @return {Popup} this
  #
  showAt: (cell)->
    @cell = cell

    return @insertTo(cell).show()

# protected

  # handles a number pick in the list
  _click: (event)->
    if event.target instanceof Cell
      @cell.mark(event.target.value());
    @hide