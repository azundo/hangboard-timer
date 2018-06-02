Base64Binary = require("./lib/base64-binary.js")

module.exports = {
	init: ->
		arrayBuff = Base64Binary.decodeArrayBuffer(@beep64)

		if AudioContext?
			@beepContext = new AudioContext()
		else if webkitAudioContext?
			@beepContext = new webkitAudioContext()
		else
			return

		@beepContext.decodeAudioData(arrayBuff, (audioData) =>
			@beepBuffer = audioData
		)

	playBeep: ->
		return if !@beepBuffer?

		beep = @beepContext.createBufferSource()
		beep.buffer = @beepBuffer
		beep.connect(@beepContext.destination)

		if AudioContext?
			beep.start(0)
		else if webkitAudioContext?
			beep.noteOn(0)

	playEndBeep: ->
		outerCount = 3
		outerDelay = 310
		innerCount = 3
		innerDelay = 135
		delay = 0

		for i in [0...outerCount]
			for j in [0...innerCount]
				delay += innerDelay

				setTimeout(=>
					@playBeep()
				, delay)

			delay += outerDelay

	playCountdownBeep: (stateDuration) ->
		outerCount = 2
		delay = stateDuration - (outerCount * 1000)
		for i in [0...outerCount]
			setTimeout(=>
				@playBeep()
			, delay)
			delay += 1000

	beep64: "SUQzBAAAAAAAF1RTU0UAAAANAAADTGF2ZjUyLjU0LjAA//tQxAAACGFJJLQSgBm0\nLO63GzACAFAHjGPGN/MhM53zvk/PQgcIogKEZTncQAMDuQiiYu5zoQjc5znfqQhM\n56HO9CN///nO//Oc587//yZCEac7oJnaAJFIBAIJBAIhAIxAIBIDAuBTj1StLqvf\n9LoFxJaPNCLkDIn/iUA+AUoAGMiyi8UgGzEGx8EUY8kTBoRci6X/yuRQuGhfTdKp\nJaKP9k3QLiBfTT///Q6DJl9MuGn///mglMiboIf8Z4G7Bki8v5YDb3f7AADEAAyR\nov/7UsQFgAtlUUW9CoABYKmoNPrReZIOtE2qYxcydBBBG6kD7mSLP//00SZLgrYB\ncBAsDgvcBkm4gACMBQKiUSobF50f//0WdqB7RUpN0WR/+f///////+p0iKGpAQFx\n+F7SZJ1khvSbZwgAVgAQHH3L4N43rRZ5ZosySU6VCpd1sr//1pGJDgvyBhIJgceq\nAHPDBfUXEQUnjVL//+yRmigpbMpaezJuvuu86cq///////+Xx5NR/ApjAaNlypUF\nCNtNgACgAA7tucj6RbutA8cR//tSxAmADDlRO6XWq8F2qif0+tF5TWy0kKknUyX+\n+upajMwJsYwMhgIDwKA8D+qmB0xBQHCijuJ0+ef/9f93Mj6BxI+ikbpTU//8tN//\n2/////WgLWMqgRcDBRPAkwxoG7GvrDklzdqAAjABH/FLRd2timEzVbqemta0loou\ngtCtv/1oF8mCBiAgAoLAwCHAN1fEDeixKBNmCal///1N1pupBLSMrVKq084Zu/Zb\nf/////+oapDy8QYDBHgVJDybMsoNyWSOgACgADK5m2zVxvn/+1LEB4ALrU9BtLqA\nCYaob78lMgJu+rWfW1kFOpR7//Wy00yGC5AxoFjIGCgOBhLtAYPGQGIAIFog4Rxk\nXSZTP//2XorXZjdk6a3/+f////////TI8ZsSmDbgABYAsTxcZkAGpuYQwOoQgEQA\nAAdhQAAIF8i4mBeRgWMGwYlwPMAVBFHACWDYejgFfA/SA0GRUl2fVRR9aZJh8pP9\nT/TNEGf/+F9wswOskw9ALCA5RFSSWv+mm6CDJ/9FH//////9ieOfkhgABPYwkM5C\n1z3Mpf/7UsQGA8qskxBdgYAAAAA0gAAABHbAtaz//lTU1NTEwE1UBAVOrxmb9m6o\nCAmFAQFYGAgJdm9VU6qrsBASiIOlQVHgq4RHlA0sFR4KuUe/9TxL+WPCWCp3/BVR\n5QNVTEFNRTMuOTdVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV\nVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV\nVVVVVVVVVVVVVVVVVVVVVVVVVVVV//tSxDkDwAABpAAAACAAADSAAAAEVVVVVVVV\nVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV\nVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV\nVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV\nVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVU=";
}
