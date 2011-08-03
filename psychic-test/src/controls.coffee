#
# A little wrapper for the controls and status
#
class Controls extends Element

  #
  # Basic constructor
  #
  # @return {Controls} this
  #
  constructor: ->
    @$super 'div', class: 'controls', html: """
      <h2>Status</h2>
      <p>
        <label>Result:</label> <span class="result">0/0 (0%)</div>
      </p>

      <p>
        <input type="button" value="Red" class="red" />
        <input type="button" value="Black" class="black" />
      </p>
    """

    @on 'click', @_click

  #
  # Resets the state
  #
  # @return {Controls} this
  #
  reset: ->
    @correct = 0
    @total   = 0

    return @update()

  #
  # Updates the counter
  #
  # @return {Controls} this
  #
  update: ->
    this.first('span.result').html("""
      #{@correct}/#{@total} (#{@result()})
    """)

    return @

  #
  # Counts an answer
  #
  # @param {Boolean} correct/wrong marker
  # @return {Controls} this
  #
  count: (correct)->
    @correct += 1 if correct
    @total   += 1

    return @update()

  #
  # Returns the current result as a %
  #
  # @return {String} result
  #
  result: ->
    "#{Math.round(@correct/(@total||1) * 100)}%"


# protected

  _click: (event)->
    if event.target.hasClass('red')
      @emit 'pick', color: 'red'
    if event.target.hasClass('black')
      @emit 'pick', color: 'black'
