express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

app = express()

# view engine setup
app.set('views', path.join __dirname, 'views')
app.set('view engine', 'pug')
app.locals.basedir = app.get('views')

# uncomment after placing your favicon in /public
# app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger 'dev')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded extended: false)
app.use(cookieParser())
app.use(express.static(path.join __dirname, 'public'))

app.use(require './lib/controllers/home')
app.use(require './lib/controllers/proposals')
app.use(require './lib/controllers/errors')

module.exports = app;
