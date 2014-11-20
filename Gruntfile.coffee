module.exports = (grunt)->
  'use strict'
  srcPath = './src'
  distPath = './assets'
  tplFiles = grunt.file.readJSON srcPath+'/tpl/files.json'
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    banner: '/*!\n' +
            ' * <%= pkg.description %>\n' +
            ' * <%= pkg.author.name %> < <%= pkg.author.email %> >\n' +
            ' * Version <%= pkg.version %> ( <%= grunt.template.today("dd-mm-yyyy") %> )\n'+
            ' */\n'
    distPath: distPath
    srcPath: srcPath
    watch:
      options:
        livereload: true
      sass:
        files: ['<%= srcPath %>/sass/**/*.scss']
        tasks: ['sass']
      coffee:
        files: ['<%= srcPath %>/coffee/**/*.coffee']
        tasks: ['coffee', 'concat:coffee']
      vendor:
        files: [
          '<%= srcPath %>/js/vendor/**/*.js'
          ]
      html:
        files: '<%= srcPath %>/tpl/**/*.tpl'
        tasks: 'newer:template:dev'

    template:
      dev:
        options:
          data:
            'cssDir': '<%= srcPath %>/css'
            'jsDir': '<%= srcPath %>/js'
            'imgDir': '<%= srcPath %>/img'
            'cssFileName': 'style'
            'jsFileName': 'main'
        files: tplFiles
      live:
        options:
          data:
            'cssDir': '<%= distPath %>/css'
            'jsDir': '<%= distPath %>/js'
            'imgDir': '<%= distPath %>/img'
            'cssFileName': 'style.min'
            'jsFileName': 'main.min'
        files: tplFiles

    sass:
      product:
        files:
          '<%= srcPath %>/css/style.css': '<%= srcPath %>/sass/style.scss'

    autoprefixer:
      options:
        browsers: [
          'Android 2.3'
          'Android >= 4'
          'Chrome >= 20'
          'Firefox >= 24'
          'Explorer >= 9'
          'iOS >= 6'
          'Opera >= 12'
          'Safari >= 6'
          ]
      prefix:
        src: '<%= srcPath %>/css/style.css'
        dest: '<%= srcPath %>/css/style.css'

    cssmin:
      build:
        options:
          banner: '<%= banner %>'
        files:
          '<%= distPath %>/css/style.min.css': '<%= srcPath %>/css/style.css'

    coffee:
      product:
        options:
          bare: true
        expand: true
        cwd: '<%= srcPath %>/coffee/'
        src: ['*.coffee']
        dest: '<%= srcPath %>/coffee/output'
        ext: '.js'

    jshint:
      files: ['<%= srcPath %>/js/*.js']
      options:
        jshintrc: '.jshintrc'

    concat:
      options:
        seperator: ';\n'
        stripBanners: true,
        banner: '<%= banner %>\n'
      coffee:
        src: [
          '<%= srcPath %>/coffee/output/*.js'
        ]
        dest: '<%= srcPath %>/js/main.js'
      css:
        src: ['<%= srcPath %>/css/style.css']
        dest: '<%= distPath %>/css/style.css'

    uglify:
      options:
        mangle: false
        banner: '<%= banner %>'
      product:
        files:
          '<%= distPath %>/js/main.min.js': '<%= distPath %>/js/main.js'

    imagemin:
      dynamic:
        options:
          optimizationLevel: 7
        files: [
            expand: true
            cwd: '<%= srcPath %>/'
            src: ['img/**/*.{png,jpg,gif}']
            dest: '<%= distPath %>/'
          ]

    clean:
      css: ['<%= distPath %>/css']
      js:  ['<%= distPath %>/js']
      img: ['<%= distPath %>/img']
      dist: [
        '<%= distPath %>'
        '*.html'
        '<%= srcPath %>/css/style.css'
        '<%= srcPath %>/css/style.css.map'
        '<%= srcPath %>/js/main.js'
        '<%= srcPath %>/coffee/output/*.js'
      ]

    copy:
      fonts:
        expand: true,
        cwd: '<%= srcPath %>',
        src: ['css/fonts/**']
        dest: '<%= distPath %>/'

      js:
        expand: true,
        cwd: '<%= srcPath %>',
        src: ['js/**']
        dest: '<%= distPath %>/'

    connect:
      server:
        options:
          port: 8000
          hostname: 'localhost'
          keepalive: true


  grunt.registerTask 'compressimg',
  [
    'clean:img'
    'imagemin'
  ]

  grunt.registerTask 'develop-mode',
  [
    'clean:dist'
    'template:dev'
    'sass'
    'coffee'
    'concat:coffee'
  ]

  grunt.registerTask 'deploy',
  [
    'clean:css'
    'clean:js'
    'template:live'
    'sass'
    'autoprefixer'
    'cssmin'
    'coffee'
    'concat'
    'copy:js'
    'uglify'
    'newer:imagemin'
    'copy:fonts'
  ]

  grunt.registerTask 'build',
  [
    'clean:css'
    'clean:js'
    'sass'
    'autoprefixer'
    'cssmin'
    'coffee'
    'concat'
    'copy:js'
    'uglify'
    'newer:imagemin'
    'copy:fonts'
  ]

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-template'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-imagemin'
  grunt.loadNpmTasks 'grunt-newer'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-notify'