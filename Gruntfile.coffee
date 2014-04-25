module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),

    # COFFEESCRIPT
    coffee:

      compile:
        expand: true,
        flatten: false,
        cwd: 'client/app/js',
        src: ['**/*.coffee'],
        dest: 'client/dist/js',
        ext: '.js'

    # LESS STYLESHEETS
    less:

      development:
        options:
          compress: true,
          yuicompress: true,
          optimization: 2
        files:
          "client/dist/styles/main.css": "client/app/styles/main.less"

    # LESS STYLESHEETS
    watch:

      styles:
        files: ['client/app/styles/**/*.less'],
        tasks: ['less'],
        options:
          nospawn: true

      coffee:
        files: ['client/app/js/**/*.coffee'],
        tasks: ['coffee'],
        options:
          nospawn: true


  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['watch']
