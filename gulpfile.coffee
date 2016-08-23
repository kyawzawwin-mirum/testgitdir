gulp = require 'gulp'
jade = require 'gulp-jade'
ts = require 'gulp-typescript'
sass = require 'gulp-sass'
copy = require 'gulp-copy'
zip = require 'gulp-zip'
flatten = require 'gulp-flatten'
clean = require 'gulp-clean'

config =
  dest: 'release'

gulp.task 'clean', () ->
  return gulp
      .src(config.dest)
      .pipe(clean({ force: true }))

gulp.task 'compile-jade', () ->
  return gulp
      .src('**/*.jade')
      .pipe(jade())
      .pipe(gulp.dest(config.dest))

gulp.task 'compile-ts', () ->
  return gulp
      .src('js/**/*.ts')
      .pipe(ts())
      .pipe(gulp.dest(config.dest))

gulp.task 'compile-scss', () ->
  return gulp
      .src('css/**/*.scss')
      .pipe(sass())
      .pipe(gulp.dest(config.dest))


gulp.task 'compile', ['compile-jade', 'compile-ts', 'compile-scss']

gulp.task 'copy', ['clean'], () ->
  return gulp
      .src('**/*.*', {cwd: 'tech'})
      .pipe(copy(config.dest))

gulp.task 'archive-release',  () ->
  return gulp
      .src([config.dest])
      .pipe(zip('release.zip'))
      .pipe(gulp.dest('.'))


# gulp.task 'default', ['clean', 'compile', 'copy', 'archive-release']
gulp.task 'default', ['copy'], () ->
  gulp.start 'compile'