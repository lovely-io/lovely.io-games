#
# The game status element
#
# Copyright (C) 2011 Nikolay Nemshilov
#
class Status extends Element

  #
  # Basic constructor
  #
  # @return {Status} this
  #
  constructor: ->
    super 'div', class: 'status'

    @timer  = new Timer()
    @levels = new Element('select', html: """
      <option value="easy">Easy</option>
      <option value="normal">Normal</option>
      <option value="hard">Hard</option>
      <option value="extreme">Extreme</option>
    """)
    @button = new Element('input', type: 'reset', value: 'Reset')

    @build()

    @levels.on('change', -> @emit('reset', level: @value()))
    @button.on('click',  -> @emit('reset'))

    return @

  #
  # Resets the status
  #
  # @return {Status} this
  #
  reset: (puzzle)->
    @timer.reset().start()
    @levels.value(puzzle.level)
    return @

# protected

  build: ->
    new Element('h3', html: "Status").insertTo(@)

    new Element('p').insert([
      new Element('label', html: 'Time:'), @timer
    ]).insertTo(@)

    new Element('p').insert([
      new Element('label', html: 'Level:'), @levels
    ]).insertTo(@)

    new Element('p').insert(@button).insertTo(@)

    return @