var coffee = require('gulp-coffee');
var del = require('del');
var gulp = require('gulp');
var mocha = require('gulp-mocha');
var sourcemaps = require('gulp-sourcemaps');
var paths = {
  build: ['build'],
  builtTests: ['build/test/**/*.js'],
  sources: ['src/coffeescript/**/*.coffee'],
  tests: ['test/coffeescript/**/*.coffee']
};


gulp.task('clean', function(cb) {
  del(paths.build, cb);
});

gulp.task('sources', ['clean'], function() {
  return gulp.src(paths.sources)
    .pipe(sourcemaps.init())
    .pipe(coffee())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('build'));
});

gulp.task('test', ['sources', 'tests'], function() {
  return gulp.src(paths.builtTests, {read: false}).pipe(mocha({reporter: 'spec', timeout: 32000}));
});

gulp.task('tests', ['clean'], function() {
  return gulp.src(paths.tests)
    .pipe(sourcemaps.init())
    .pipe(coffee())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('build/test'));
});

gulp.task('watch', function() {
  gulp.watch(paths.sources, ['sources']);
  gulp.watch(paths.tests, ['tests']);
});

gulp.task('build', ['sources', 'tests']);

gulp.task('default', ['build']);