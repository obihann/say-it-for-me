fs = require 'fs'
request = require 'request'
gm = require 'gm'
uuid = require 'node-uuid'

class SIFMImg
	constructor: () ->
		@imgNum = Math.floor (Math.random()*16) + 1

	cat: (cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"

		request(img, (err, resp, body) ->
			cb localImg
		).pipe (
			fs.createWriteStream localImg
		)

	catbw: (cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"

		request(img, (err, resp, body) ->
			rs = fs.createReadStream localImg

			gm(rs, @imgNum + ".jpeg").type("Grayscale").write(localImg, (err) ->
				console.log err if err
				cb localImg
			)

		).pipe (
			fs.createWriteStream localImg
		)

	catsize: (width, height, cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"

		request(img, (err, resp, body) ->
			rs = fs.createReadStream localImg

			gm(rs, @imgNum + ".jpeg").resize(width, height).write(localImg, (err) ->
				console.log err if err
				cb localImg
			)

		).pipe (
			fs.createWriteStream localImg
		)

	catsizebw: (width, height, cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"

		request(img, (err, resp, body) ->
			rs = fs.createReadStream localImg

			gm(rs, @imgNum + ".jpeg").resize(width, height).type("Grayscale").write(localImg, (err) ->
				console.log err if err
				cb localImg
			)

		).pipe (
			fs.createWriteStream localImg
		)

module.exports = SIFMImg