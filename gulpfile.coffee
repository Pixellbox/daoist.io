gulp = require('gulp')
sass = require('gulp-sass')
concat = require('gulp-concat')

paths =
  sass: 'sass/**/*.scss'

gulp.task 'sass', ->
  gulp
    .src(paths.sass)
    .pipe(sass().on 'error', sass.logError)
    .pipe(concat('style.css'))
    .pipe(gulp.dest 'public/stylesheets')

gulp.task 'watch', ['default'], ->
  gulp.watch paths.sass, ['sass']

gulp.task 'default', ['sass']
