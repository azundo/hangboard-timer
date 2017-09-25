$ = require("npm-zepto")
C = require("./constants.coffee")
Dom = require("./dom.coffee")

Card = class Card
	# this must match $angle-count in css/stage_play.sass
	angleCount: 10

	constructor: ->
		@el = $(@template())
		Dom.stages.play.prepend(@el)
		@time = @el.find(".card-time")
		@status = @el.find(".card-status")
		@rep = @el.find(".card-rep")

		if state?
			@update(state)

	template: ->
		return """
			<div class="card">
				<span class="card-status"></span>
				<span class="card-time"></span>
				<span class="card-rep"></span>
			</div>
		"""

	update: (nextState) ->
		return if !nextState?

		if @state?.time != nextState.time && nextState.timeGoal
			time = @formatCountdown(nextState.time, nextState.timeGoal)
			@time.html(time)

		if @state?.status != nextState.status
			@el.addClass("card--#{nextState.status}")
			text = C.phrases[nextState.status]
			@status.text(text)

		if @state?.rep != nextState.rep
			@rep.text(nextState.rep)

		@state = nextState

	destroy: ->
		i = Math.floor(Math.random() * @angleCount)
		@el.addClass("card--is-leaving-#{i}")

		setTimeout(=>
			@el.remove()
		, 1000)

	formatCountdown: (current, goal) ->
		time = goal - current

		# keep in bounds
		if time < 0
			time = 0

		time = "#{time / 1000}"

		# make counts that divide evenly look good by adding more zeros at the end
		if time.indexOf(".") < 0
			time = "#{time}.000"

		time = time.split(".")
		# do an effective ceil here
		if time[1] > 0
			time[0] = parseInt(time[0]) + 1

		# if we're over a minute, format into minute and second counts
		if time[0] > 59
			minutes = Math.floor(time[0] / 60)
			seconds = time[0] % 60

			if seconds < 10
				seconds = "0#{seconds}"

			return "#{minutes}<span class='colon'>:</span>#{seconds}"

		# return seconds remaining
		return time[0]

module.exports = Card
