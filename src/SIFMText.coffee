_ = require 'underscore'
loremIpsum = require 'lorem-ipsum'
dictionary = require './dictionary.js'

class SIFMText
	farm = dictionary

	constructor: (opts) ->
		@options = {
			count: 5
			units: "paragraphs"
			format: "html"
		}

		_.each opts, (value, key) ->
			@options[key] = value
		, @

	mixParagraph: (mix) ->
		sentances = _.range 1, Math.floor (Math.random() * 5) + 3
		paragraph = ""

		_.each sentances, () ->
			ipsum = loremIpsum {
				units: "sentences"
			}

			words = ipsum.split " "
			ammountOfMix = mix.length

			sentance = ""

			_.each words, (word, x) ->
				iPos = Math.floor (Math.random() * 5) + 2
				aPos = (Math.floor (Math.random() * ammountOfMix) + 1) - 1
				word = mix[aPos] if x % iPos == 0
				sentance += " " + word
			, @

			cleanSentance = sentance.charAt(1).toUpperCase() + sentance.slice(2)
			cleanSentance += "." if cleanSentance.charAt(cleanSentance.length - 1) != "."

			paragraph += cleanSentance + " "
		, @

		paragraph = "<p>" + paragraph + "</p>"

	mixedIpsum: (mix) ->
		paragraphs = _.range 1, @options.count
		sentance = ""

		_.each paragraphs, () ->
			sentance += @mixParagraph(mix)
		, @

		sentance

	ipsum: ->
		loremIpsum @options

	bacon: ->
		@mixedIpsum farm.meat

module.exports = SIFMText
