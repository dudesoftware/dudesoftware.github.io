module.exports = (grunt) ->
  deps = grunt.file.readJSON('package.json').devDependencies

  grunt.initConfig
    bower:
      install:
        options:
          targetDir: './bower_components'

    compass:
      main:
        options:
          bundleExec: true
          sassDir: 'sass'
          cssDir: 'build'

    cssmin:
      main:
        files:
          'css/main.css': $w 'bower_components/normalize-css/normalize.css build/prefixed.main.css'

    autoprefixer:
      main:
        src: 'build/gumby.css'
        dest: 'build/prefixed.main.css'

    uglify:
      main:
        files:
          'js/modernizr.js': './bower_components/gumby/js/libs/modernizr-2.6.2.min.js'
          'js/main.js': $w '''
            bower_components/gumby/js/libs/jquery-2.0.2.min.js
            ./bower_components/gumby/js/libs/gumby.js
            ./bower_components/gumby/js/libs/ui/gumby.retina.js
            ./bower_components/gumby/js/libs/ui/gumby.fixed.js
            ./bower_components/gumby/js/libs/ui/gumby.skiplink.js
            ./bower_components/gumby/js/libs/ui/gumby.toggleswitch.js
            ./bower_components/gumby/js/libs/ui/gumby.checkbox.js
            ./bower_components/gumby/js/libs/ui/gumby.radiobtn.js
            ./bower_components/gumby/js/libs/ui/gumby.tabs.js
            ./bower_components/gumby/js/libs/ui/gumby.navbar.js
            ./bower_components/gumby/js/libs/ui/jquery.validation.js
            ./bower_components/gumby/js/libs/gumby.init.js
            ./bower_components/gumby/js/plugins.js
            ./bower_components/gumby/js/main.js
          '''

    watch:
      sass:
        files: $w 'sass/*.scss'
        tasks: $w 'compass autoprefixer cssmin'

  for pkg of deps when pkg.indexOf('grunt-') is 0
    grunt.loadNpmTasks pkg

  grunt.registerTask 'default', $w 'bower compass autoprefixer cssmin uglify'

# Helpers
# -------

$w = (str) -> str.split(/\s+/)
