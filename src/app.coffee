express = require 'express'
SIFMText = require './SIFMText.js'
SIFMImg = require './SIFMImg.js'

app = express()

app.get '/ipsum', (req, res) ->
	sifm = new SIFMText {
		count: 10
		units: "paragraphs"
		format: "html"
	}

	res.send sifm.ipsum()

app.get '/bacon', (req, res) ->
	sifm = new SIFMText {
		count: 10
		units: "paragraphs"
		format: "html"
	}

	res.send sifm.bacon()

app.get '/cats', (req, res) ->
	sifm = new SIFMImg()

	sifm.cat (img) ->
		res.sendfile img

app.get '/cats/bw', (req, res) ->
	sifm = new SIFMImg()

	sifm.catbw (img) ->
		res.sendfile img

app.get '/cats/:width/:height', (req, res) ->
	sifm = new SIFMImg()

	sifm.catsize req.params.width, req.params.height, (img) ->
		res.sendfile img

app.get '/cats/:width/:height/bw', (req, res) ->
	sifm = new SIFMImg()

	sifm.catsizebw req.params.width, req.params.height, (img) ->
		res.sendfile img

port = process.env.PORT || 3000
app.listen port, () ->
    console.log('Listening on ' + port)
