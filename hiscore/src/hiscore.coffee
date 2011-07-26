#
# Project's main unit. Basically a subclass of `dom.Element`
# that wraps and `OL` element.
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Hiscore extends Element
  include: core.Options
  extend:
    # default options
    Options:
      key:  'hiscore' # the hiscore cookie-key
      size: 10        # maximum number of winnars on the list

    i18n:
      NoRecords: "No records yet"

  #
  # Basic constructor
  #
  # @params {Object} HTML and Hiscore options
  # @return {Hiscore} element
  #
  constructor: (options)->
    @setOptions(options)
    options = Hash.reject(options, (key)-> key of Hiscore.Options)
    super('ol', options)
    @addClass('hiscore')
    @on "keyup", @_keyup
    @build()

  #
  # Adds a new result to the list.
  #
  # It checks if the result fits the list and then
  # prompts the user to enter his name for the record
  #
  # @param {String|Number} result
  # @return {Hiscore} this
  #
  add: (result)->
    name  = new Element('input', value: @lastName())
    value = parseInt((''+result).replace(/[^\d]/g, ''))
    entry = @entry([name, result]).addClass('new-score')
    found = false

    @html('') if @empty()
    input.parent().remove() if input = @first('input')

    for item in @children()
      score = parseInt(item.first('.score').text().replace(/[^\d]/g, ''))

      if value > score
        entry.insertTo(item, 'before')
        found = true
        break

    @insert(entry) if !found
    @children().pop().remove() if @options.size and @children().length > @options.size

    input.focus() if input = @first('input')

    return @removeClass('empty')

  #
  # Clears up the score list and all the saved data
  #
  # @return {Hiscore} this
  #
  clear: ()->
    return @$super().save().build()

  #
  # Replacing the original method so that it worked with
  # the 'empty list' entry
  #
  # @return {Boolean} check result
  #
  empty: ()->
    @hasClass('empty')

# private

  # builds the list
  build: ()->
    entries = (@entry(entry) for entry in Cookie.get(@options.key) || [])

    if entries.length is 0
      entries.push(@entry([Hiscore.i18n.NoRecords, '']))
      @addClass('empty')

    @html('').insert(entries)


  # builds an entry for the list
  entry: (entry)->
    new Element('li').append(
      new Element('span', class: 'score').text(entry[1]),
      if entry[0] instanceof Element then entry[0]
      else new Element('span', class: 'name').text(entry[0]))


  # handles the last player name storage
  lastName: (value)->
    if arguments.length is 0
      Cookie.get('hiscore-last-name') || ''
    else
      Cookie.set('hiscore-last-name', value)


  # handles keypresses on the name input field
  _keyup: (event)->
    if event.keyCode is 27      # Escape pressed
      @build() # just rebuilding the list without saving it
    else if event.keyCode is 13 # Enter pressed
      input = @first('input')
      item  = input.parent()
      name  = input.value()
      item.replace(@entry([name, item.first('.score').text()]))
      @lastName(name)
      @save().build()


  # saves the list of current entries in the in cookies
  save: ()->
    records = []

    for item in @children()
      name  = item.first('.name').text()
      score = item.first('.score').text()
      dup   = false

      for entry in records
        if entry[0] is name and entry[1] is score
          dup = true
          break

      records.push([name, score]) unless dup

    if @options.size
      records = records.slice(0, @options.size)

    Cookie.set(@options.key, records)

    return @