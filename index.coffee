express = require('express.io')
path = require 'path'

app = require('express.io')()
app.http().io()
app.use express.static path.join __dirname, 'client'
app.use express.session {secret: 'sbks feature tool'}
	
console.log 'Listening at http://localhost:2014/'
app.listen 2014
