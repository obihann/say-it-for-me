express = require 'express'
_ = require 'underscore'
app = express()

ipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam rutrum ipsum a lobortis accumsan. Maecenas eleifend tempor tempus. Duis id tellus id metus ullamcorper mollis. Quisque eget tortor porta, laoreet augue et, ultrices nunc. Phasellus lectus massa, vehicula vitae eleifend viverra, volutpat sit amet dolor. Quisque massa leo, vehicula in purus vitae, auctor iaculis nibh. Fusce eget laoreet erat. Donec nibh purus, ultricies a lacus eget, viverra aliquet nulla. Cras dapibus cursus lectus, nec aliquam urna accumsan quis. Donec molestie hendrerit tristique. Aenean feugiat lacus lectus, lobortis consectetur purus gravida quis.
Praesent vitae ullamcorper felis. Suspendisse feugiat nibh at turpis ultricies scelerisque. Cras viverra cursus nisi, sit amet pretium arcu tristique eget. Mauris a nisl et mauris fringilla hendrerit sit amet in justo. Nunc porta, tellus sit amet blandit blandit, metus sapien tempus nibh, vitae iaculis nisl nisl ultrices enim. Curabitur ac vestibulum purus. Donec varius a urna vitae rutrum. Praesent vitae est in tortor condimentum suscipit. Nullam tempus congue venenatis. Pellentesque eu sollicitudin nibh, ac iaculis justo. Nulla gravida gravida gravida. Sed quis consequat quam.
Curabitur aliquet turpis lacus, eu molestie augue viverra vitae. Morbi est libero, pretium eu semper sit amet, pulvinar id tellus. Nulla dapibus ante vitae risus rutrum dictum. Ut porttitor volutpat arcu sed eleifend. Duis eu pharetra libero, quis mattis lectus. Vivamus id sagittis ante, a hendrerit est. Nulla eu dictum justo, at sollicitudin purus.
Phasellus dapibus id velit nec sollicitudin. Donec faucibus erat quis tincidunt dictum. Fusce posuere sodales feugiat. Fusce auctor ligula in ipsum consectetur consequat. Maecenas sem odio, tempus non risus pulvinar, lacinia lobortis neque. Praesent vestibulum eleifend massa at cursus. Morbi vulputate vehicula felis, vitae feugiat eros pharetra eu. Aenean eu fringilla ante. Nunc vel mollis libero. Donec nisl sapien, pretium quis libero vitae, tincidunt commodo justo. Nullam porttitor leo non tortor fermentum fringilla. Pellentesque ultrices gravida neque, sit amet ultrices dolor commodo id. Nulla faucibus egestas laoreet. Ut et euismod erat.
Integer sodales purus at nulla mattis, in facilisis purus faucibus. Quisque libero dui, egestas quis gravida a, accumsan non eros. Fusce cursus, metus id accumsan elementum, mauris metus sagittis nisi, eu suscipit dui massa ut lorem. Integer consequat sodales elit, nec tincidunt tortor laoreet vitae. Duis viverra congue adipiscing. Etiam in viverra eros. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur faucibus, risus sit amet hendrerit lacinia, nisl purus placerat odio, non bibendum lorem quam aliquam felis. Curabitur molestie laoreet sem, sit amet vulputate nibh. Phasellus tristique est a eros sodales sodales.'

meat = [
	'beef',
	'chicken',
	'pork',
	'bacon',
	'chuck',
	'short loin',
	'sirloin',
	'shank',
	'flank',
	'sausage',
	'pork belly',
	'shoulder',
	'cow',
	'pig',
	'ground round',
	'hamburger',
	'meatball',
	'tenderloin',
	'strip steak',
	't-bone',
	'ribeye',
	'shankle',
	'tongue',
	'tail',
	'pork chop',
	'pastrami',
	'corned beef',
	'jerky',
	'ham',
	'fatback',
	'ham hock',
	'pancetta',
	'pork loin',
	'short ribs',
	'spare ribs',
	'beef ribs',
	'drumstick',
	'tri-tip',
	'ball tip',
	'venison',
	'turkey',
	'biltong',
	'rump',
	'jowl',
	'salami',
	'bresaola',
	'meatloaf',
	'brisket',
	'boudin',
	'andouille',
	'capicola',
	'swine',
	'kielbasa',
	'frankfurter',
	'prosciutto',
	'filet mignon',
	'leberkas',
	'turducken',
	'doner',
	'kevin'
	]

app.get '/ipsum', (req, res) ->
	body = ipsum
	res.setHeader 'Content-Type', 'text/plain'
	res.setHeader 'Content-Length', body.length
	res.end body


app.get '/bacon', (req, res) ->
	num = Math.floor (Math.random()*10)+3
	words = ipsum.split " "
	baconIpsum = ""

	_.each words, (word, x) ->
		word = meat.shift() if x % num == 0
		baconIpsum += word + " "

	body = baconIpsum
	res.setHeader 'Content-Type', 'text/plain'
	res.setHeader 'Content-Length', body.length
	res.end body

app.listen 3000
console.log 'Listening on port 3000'