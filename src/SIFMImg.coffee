fs = require 'fs'
request = require 'request'
gm = require 'gm'
imageMagick = gm.subClass { imageMagick: true }
uuid = require 'node-uuid'
AWS = require 'aws-sdk'
AWS.config.update
	accessKeyId:process.env.AWS_ACCESS_KEY_ID
	secretAccessKey:process.env.AWS_SECRET_ACCESS_KEY
	region:process.env.AWS_REGION
s3 = new AWS.S3()

class SIFMImg
	constructor: () ->
		@imgNum = Math.floor (Math.random()*16) + 1

	cat: (cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"
		file = fs.createWriteStream localImg
		_imgNum = @imgNum

		file.on 'close', () ->
			console.log "success"
			cb localImg

		params = 
			Bucket: 'sayitforme'
			Key: "cats/" +_imgNum + ".jpeg"

		s3.getObject(params).createReadStream().pipe(file)

	catbw: (cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"
		file = fs.createWriteStream localImg
		_imgNum = @imgNum

		file.on 'close', () ->
			rs = fs.createReadStream localImg
			imageMagick(rs, _imgNum + ".jpeg").type("Grayscale").write(localImg, (err) ->
				console.log err if err

				fs.readFile localImg, (lErr, lData) ->
					console.log lErr if lErr

					s3.client.putObject
						ACL:'public-read'
						Body: lData
						Key: "cats/" +_imgNum + "-bw.jpeg"
						Bucket: "sayitforme"
					, (s3e, s3d) ->
						console.log s3e if s3e

				cb localImg
			)

		params = 
			Bucket: 'sayitforme'
			Key: "cats/" + _imgNum + "-bw.jpeg"

		s3.getObject(params).createReadStream().pipe(file)
		
		#_imgNum = @imgNum

		#request(img, (err, resp, body) ->
			#rs = fs.createReadStream localImg
			
			#gm(rs, @imgNum + ".jpeg").type("Grayscale").write(localImg, (err) ->
				#console.log err if err

				#fs.readFile localImg, (lErr, lData) ->
					#console.log lErr if lErr

					#s3.client.putObject
						#ACL:'public-read'
						#Body: lData
						#Key: "cats/" +_imgNum + "-bw.jpeg"
						#Bucket: "sayitforme"
					#, (s3e, s3d) ->
						#console.log s3e if s3e

				#cb localImg
			#)

		#).pipe (
			#fs.createWriteStream localImg
		#)

	catsize: (width, height, cb) ->
		img = "http://s3-us-west-2.amazonaws.com/sayitforme/cats/" + @imgNum + ".jpeg"
		localImg = "/tmp/" + uuid.v1() + ".jpeg"

		request(img, (err, resp, body) ->
			rs = fs.createReadStream localImg

			imageMagick(rs, @imgNum + ".jpeg").resize(width, height).write(localImg, (err) ->
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

			imageMagick(rs, @imgNum + ".jpeg").resize(width, height).type("Grayscale").write(localImg, (err) ->
				console.log err if err
				cb localImg
			)

		).pipe (
			fs.createWriteStream localImg
		)

module.exports = SIFMImg
