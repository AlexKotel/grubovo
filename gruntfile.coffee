# Dependencies
# =============================================================================
dep =

	scripts: [
		'bower_components/async/lib/async.js'
		'bower_components/jquery/dist/jquery.js'
		'bower_components/lodash/dist/lodash.js'
		'bower_components/parsleyjs/dist/parsley.js'
		'bower_components/bootstrap/dist/js/bootstrap.js'
	]

	styles: [
		'bower_components/bootstrap/dist/css/bootstrap.css'
	]


# Distribution
# =============================================================================
dist =

	dep: [
		'dist/dep/js/jquery.js'
		'dist/dep/js/angular.js'
		'dist/dep/js/*.js'
	]

	app: [
		'dist/js/app.js'
		'dist/js/**/*.js'
	]
	
	styles: [
		'dist/dep/css/*.css'
		'dist/css/app.css'
		'dist/css/*.css'
	]


# Configuration
# =============================================================================
module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)

	grunt.initConfig

		dep: dep
		dist: dist

		env:
			dev:
				NODE_ENV: 'DEVELOPEMENT'
			prod:
				NODE_ENV: 'PRODUCTION'

		copy:
			img:
				expand: true
				cwd: 'src/img'
				dest: 'dist/img'
				src: '**'
			font:
				expand: true
				cwd: 'src/font'
				dest: 'dist/font'
				src: '**'
			data:
				expand: true
				cwd: 'src/data'
				dest: 'dist/data'
				src: '**'
			depScripts:
				expand: true
				flatten: true
				src: '<%= dep.scripts %>'
				dest: 'dist/dep/js'
			depStyles:
				expand: true
				flatten: true
				src: '<%= dep.styles %>'
				dest: 'dist/dep/css'
			iconfont: 
				files: [
					expand: true
					cwd: 'src/tools/iconfont/dist'
					src: '*.{woff,ttf,eot,svg}'
					dest: 'dist/font'
				,
					expand: true
					cwd: 'src/tools/iconfont/dist'
					src: '*.css'
					dest: 'src/stylus/tools'
					ext: '.styl'
				]
			svgsprite: 
				files: [
					expand: true
					cwd: 'src/tools/svgsprite/dist/svg'
					src: '*.svg'
					dest: 'dist/img'
				,
					expand: true
					cwd: 'src/tools/svgsprite/dist'
					src: '*.css'
					dest: 'src/stylus/tools'
					ext: '.styl'
				]
			pngsprite: 
				files: [
					expand: true
					cwd: 'src/tools/pngsprite/dist'
					src: '*.png'
					dest: 'dist/img'
				,
					expand: true
					cwd: 'src/tools/pngsprite/dist'
					src: '*.css'
					dest: 'src/stylus/tools'
					ext: '.styl'
				]
			sprite: 
				files: [
					expand: true
					cwd: 'src/tools/sprite/dist'
					src: '*.png'
					dest: 'dist/img'
				,
					expand: true
					cwd: 'src/tools/sprite/dist'
					src: '*.css'
					dest: 'src/stylus/tools'
					ext: '.styl'
				]

		jade:
			options:
				pretty: true
			files:
				expand: true
				cwd: 'src'
				src: '*.jade'
				dest: 'dist'
				ext: '.html'

		coffee:
			options:
				bare: false
			files:
				expand: true
				cwd: 'src/coffee'
				src: '**/*.coffee'
				dest: 'dist/js'
				ext: '.js'

		coffeelint:
			options:
				force: true
			files:
				expand: true
				cwd: 'src/coffee'
				src: '**/*.coffee'

		stylus:
			options:
				compress: false
			files:
				expand: true
				cwd: 'src/stylus'
				src: 'app.styl'
				dest: 'dist/css'
				ext: '.css'

		htmlbuild:
			options:
				beautify: true
				styles:
					dev: '<%= dist.styles %>'
					prod: '<%= cssmin.files.dest %>'
				scripts:
					dev: ['<%= dist.dep %>', '<%= dist.app %>']
					prod: '<%= uglify.files.dest %>'
			files:
				src: 'dist/*.html'
				dest: 'dist'

		svgmin:
			img:
				expand: true
				cwd: 'src/img'
				src: '**/*.svg'
				dest: 'dist/img'
			iconfont:
				expand: true
				cwd: 'src/tools/iconfont/src'
				src: '*.svg'
				dest: 'src/tools/iconfont/dist/optimized'
			svgsprite:
				expand: true
				cwd: 'src/tools/svgsprite/src'
				src: '*.svg'
				dest: 'src/tools/svgsprite/dist/optimized'

		imagemin:
			options:
				optimizationLevel: 3
				pngquant: true
			img:
				expand: true
				cwd: 'src/img'
				src: '**/*.{png,jpg,gif}'
				dest: 'dist/img'
			sprite:
				expand: true
				cwd: 'src/tools/sprite/src'
				src: '*.png'
				dest: 'src/tools/sprite/dist/optimized'
			pngsprite1x:
				expand: true
				cwd: 'src/tools/pngsprite/src/x1'
				src: '*.png'
				dest: 'src/tools/pngsprite/dist/optimized/x1'
			pngsprite2x:
				expand: true
				cwd: 'src/tools/pngsprite/src/x2'
				src: '*.png'
				dest: 'src/tools/pngsprite/dist/optimized/x2'

		webfont:
			icons:
				options:
					font: 'ficon'
					engine: 'node'
					hashes: false
					htmlDemo: false
					relativeFontPath: '../font'
					templateOptions:
						baseClass: 'fi'
						classPrefix: 'fi-'
				src: 'src/tools/iconfont/dist/optimized/*.svg'
				dest: 'src/tools/iconfont/dist'
				destCss: 'src/tools/iconfont/dist'

		sprite:
			options:
				algorithm: 'binary-tree'
				engine: 'pngsmith'
				padding: 8
				imgOpts:
					format: 'png'
			simple:
				src: 'src/tools/sprite/dist/optimized/*.png'
				destImg: 'src/tools/sprite/dist/sprite.png'
				destCSS: 'src/tools/sprite/dist/sprite.css'
				imgPath: '../img/sprite.png'
				cssOpts:
					cssClass: (item) -> ".i.i-#{item.name}"
			x1:
				src: 'src/tools/pngsprite/dist/optimized/x1/*.png'
				destImg: 'src/tools/pngsprite/dist/pngsprite@1x.png'
				destCSS: 'src/tools/pngsprite/dist/pngsprite.css'
				imgPath: '../img/pngsprite@1x.png'
				cssOpts:
					cssClass: (item) -> ".png.png-#{item.name}"
			x2:
				src: 'src/tools/pngsprite/dist/optimized/x2/*.png'
				destImg: 'src/tools/pngsprite/dist/pngsprite@2x.png'
				destCSS: 'src/tools/pngsprite/dist/pngsprite.css'
				imgPath: '../img/pngsprite@2x.png'

		svgsprite:
			icons:
				src: 'src/tools/svgsprite/dist/optimized'
				dest: 'src/tools/svgsprite/dist'
				options:
					dims: true
					common: 'svg'
					sprite: 'svgsprite'
					render:
						css:
							dest: 'svgsprite.css'

		concat:
			styles:
				src: '<%= dist.styles %>'
				dest: 'dist/tmp/styles.concated.css'
			dep:
				src: '<%= dist.dep %>'
				dest: 'dist/tmp/dep.concated.js'
			app:
				src: '<%= dist.app %>'
				dest: 'dist/tmp/app.concated.js'
			build:
				src: ['dist/tmp/dep.concated.js', 'dist/tmp/app.concated.js']
				dest: 'dist/tmp/build.concated.js'

		uglify:
			files:
				src: '<%= concat.build.dest %>'
				dest: "dist/js/build-#{Date.now()}.js"

		cssmin:
			files:
				src: '<%= concat.styles.dest %>'
				dest: "dist/css/build-#{Date.now()}.css"

		htmlmin:
			options:
				removeComments: true
				removeCommentsFromCDATA: true
				removeCDATASectionsFromCDATA: true
				collapseWhitespace: false
				collapseBooleanAttributes: true
				removeAttributeQuotes: true
				removeRedundantAttributes: true
				useShortDoctype: true
				removeOptionalTags: true
				removeEmptyAttributes: true
			dist:
				expand: true
				cwd: 'dist'
				src: '*.html'
				dest: 'dist'
				ext: '.html'

		watch:
			options: 
				livereload: true
			img:
				files: ['src/img/**/*']
				tasks: ['newer:copy:img']
			font:
				files: ['src/font/**/*']
				tasks: ['newer:copy:font']
			data:
				files: ['src/data/**/*']
				tasks: ['newer:copy:data']
			stylus:
				files: ['src/stylus/**/*']
				tasks: ['stylus']
			jade:
				files: ['src/jade/**/*', 'src/*.jade']
				tasks: [
					'jade'
					'htmlbuild'
				]
			coffee:
				files: ['src/coffee/**/*']
				tasks: [
					'newer:coffeelint'
					'newer:coffee'
				]
			iconfont:
				files: ['src/tools/iconfont/src/**/*']
				tasks: [
					'newer:svgmin:iconfont'
					'webfont'
					'copy:iconfont'
				]
			sprite:
				files: ['src/tools/sprite/src/**/*']
				tasks: [
					'newer:imagemin:sprite'
					'sprite:simple'
					'copy:sprite'
				]
			pngsprite:
				files: ['src/tools/pngsprite/src/**/*']
				tasks: [
					'newer:imagemin:pngsprite1x'
					'newer:imagemin:pngsprite2x'
					'sprite:x2'
					'sprite:x1'
					'copy:pngsprite'
				]
			svgsprite:
				files: ['src/tools/svgsprite/src/**/*']
				tasks: [
					'newer:svgmin:svgsprite'
					'svgsprite'
					'copy:svgsprite'
				]

		connect:
			dev:
				options:
					port: 8001
					base: 'dist'
			prod:
				options:
					port: 8001
					base: 'dist'
					keepalive: true

		clean:
			dist: 'dist'
			tmp: 'dist/tmp'
			final: [
				'dist/dep'
				'dist/css'
				'dist/js'
			]
			tools: [
				'src/tools/sprite/dist'
				'src/tools/iconfont/dist'
				'src/tools/svgsprite/dist'
				'src/tools/pngsprite/dist'
				'src/tools/datasprite/dist'
			]

	grunt.registerTask 'tools', [
		'clean:tools'
		'svgmin:iconfont'
		'svgmin:svgsprite'
		'imagemin:sprite'
		'imagemin:pngsprite1x'
		'imagemin:pngsprite2x'
		'sprite:simple'
		'sprite:x2'
		'sprite:x1'
		'svgsprite'
		'webfont'
		'copy:iconfont'
		'copy:svgsprite'
		'copy:pngsprite'
		'copy:sprite'
	]

	grunt.registerTask 'default', [
		'env:dev'
		'clean'
		'tools'
		'jade'
		'stylus'
		'coffeelint'
		'coffee'
		'copy:img'
		'copy:data'
		'copy:font'
		'copy:depScripts'
		'copy:depStyles'
		'htmlbuild'
		'connect:dev'
		'watch'
	]

	grunt.registerTask 'build', [
		'env:prod'
		'clean'
		'tools'
		'jade'
		'stylus'
		'coffeelint'
		'coffee'
		'svgmin:img'
		'imagemin:img'
		'copy:data'
		'copy:font'
		'copy:depScripts'
		'copy:depStyles'
		'concat:styles'
		'concat:dep'
		'concat:app'
		'concat:build'
		'clean:final'
		'uglify'
		'cssmin'
		'htmlbuild'
		'htmlmin'
		'clean:tmp'
		'clean:tools'
		'connect:prod'
	]