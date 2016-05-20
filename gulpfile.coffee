gulp = require('gulp')
sass = require('gulp-sass')
concat = require('gulp-concat')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
combinedStream = require('combined-stream')
del = require('del')
bower = require('gulp-bower')

env = process.env.NODE_ENV or 'development'

paths =
  sass: 'client/sass/application.scss'
  coffee: 'client/coffee/application.coffee'
  js: ['vendor/jquery/dist/jquery.min.js']
  css: []
  bower: ['bower.json']

sassConfig =
  outputStyle: (env is 'development' and 'expanded') or 'compressed'
  includePaths: ['vendor/bootstrap-sass/assets/stylesheets']

gulp.task 'css', ->
  stream = combinedStream.create()
  stream.append gulp.src(paths.css)
  stream.append gulp.src(paths.sass).pipe(sass(sassConfig).on 'error', sass.logError)
  stream
    .pipe(concat('application.css'))
    .pipe(gulp.dest 'public')

gulp.task 'js', ->
  stream = combinedStream.create()
  stream.append gulp.src(paths.js)
  stream.append gulp.src(paths.coffee).pipe(coffee(bare: true).on 'error', gutil.log)
  stream
    .pipe(concat 'application.js')
    .pipe(gulp.dest 'public')

gulp.task 'watch', ['default'], ->
  gulp.watch paths.sass, ['css']
  gulp.watch paths.coffee, ['js']
  gulp.watch paths.js, ['js']
  gulp.watch paths.bower, ['css', 'js']

gulp.task 'clear', (cb) ->
  del ['public/application.js', 'public/application.css'], cb

gulp.task 'bower', ->
  bower()

gulp.task 'default', ['bower', 'css', 'js']
