module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    loadPath: require('node-bourbon').includePaths

    sass:
      options:
        includePaths: require('node-bourbon').includePaths
      dist:
        files:
          'public/stylesheets/style.css':'public/stylesheets/scss/style.scss'

    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: 'public/coffee/'
        src: ['*.coffee']
        dest: 'public/javascripts/'
        ext: ".js"

    clean: ['public/module.js', 'public/stylesheets/style.css']

    browserify:
      dist:
        files:
          'public/module.js':['public/**/*.coffee']
        options:
          transform: ['coffeeify']
          watch: true
          #keepAlive: true
          watchifyOptions:
            outFile: 'public/module.js'
            verbose:true

    nodemon:
      nodeArgs: ['--debug']
      dev:
        script: 'bin/www'

        callback: (nodemon) ->
          nodemon.on 'log', (event) ->
            console.log event.color
    
  )

  grunt.loadNpmTasks 'grunt-nodemon'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-watchify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', ['sass', 'browserify', 'nodemon']
