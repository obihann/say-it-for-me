redis = require 'redis'
fs = require 'fs'
express = require 'express'
request = require 'request'
gm = require 'gm'
uuid = require 'node-uuid'
SIFMText = require './SIFMText.coffee'

app = express()
client = redis.createClient()

pickImage = ->
	Math.floor (Math.random()*16) + 1

app.get '/ipsum', (req, res) ->
	sifm = new SIFMText {
		count: 10
		units: "paragraphs"
		format: "html"
	}

	res.end sifm.ipsum()

app.get '/bacon', (req, res) ->
	sifm = new SIFMText {
		count: 10
		units: "paragraphs"
		format: "html"
	}

	res.end sifm.bacon()

app.get '/cats', (req, res) ->
	res.contentType = 'image/jpeg';

	client.get( 'cats', (err, result) ->
		if err | !result
			image = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + pickImage() + ".jpeg"
			local = "/tmp/" + uuid.v1() + ".jpeg"
			request(image, (err, response, body) ->
				client.setex 'cats', 21600, body
				rs = fs.createReadStream local
				rs.on 'open', () ->
					rs.pipe res
			).pipe (
				fs.createWriteStream local
			)
		else
			res.send new Buffer(result, 'base64')
	)

app.get '/cats/bw', (req, res) ->
	res.contentType = 'image/jpeg';

	num = pickImage()
	image = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + num + ".jpeg"
	local = "/tmp/" + uuid.v1() + ".jpeg"

	request( image, (err, resp, body) ->
		rs = fs.createReadStream local

		gm(rs, num + ".jpeg").type("Grayscale").write(local, (err) ->
			console.log err if err
			res.sendfile local
		)
	).pipe (
		fs.createWriteStream local
	)

app.get '/cats/:width/:height', (req, res) ->
	res.contentType = 'image/jpeg';

	num = pickImage()
	image = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + num + ".jpeg"
	local = "/tmp/" + uuid.v1() + ".jpeg"

	request( image, (err, resp, body) ->
		rs = fs.createReadStream local

		gm(rs, num + ".jpeg").resize(req.params.width, req.params.height).write(local, (err) ->
			console.log err if err
			res.sendfile local
		)
	).pipe (
		fs.createWriteStream local
	)

app.get '/cats/:width/:height/bw', (req, res) ->
	res.contentType = 'image/jpeg';

	num = pickImage()
	image = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + num + ".jpeg"
	local = "/tmp/" + uuid.v1() + ".jpeg"

	request( image, (err, resp, body) ->
		rs = fs.createReadStream local

		gm(rs, num + ".jpeg").resize(req.params.width, req.params.height).type("Grayscale").write(local, (err) ->
			console.log err if err
			res.sendfile local
		)
	).pipe (
		fs.createWriteStream local
	)

app.listen 3000
console.log 'Listening on port 3000'