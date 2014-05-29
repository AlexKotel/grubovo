:skull: GRUBOVO :skull:
=======================

Features
--------

Preprocessors
- jade
- coffee
- stylus

Optimizations
- concat
- uglify
- imgmin
- svgmin
- cssmin
- htmlmin

Tools
- pngsprite (+retina)
- svgsprite
- iconfont
- coffeelint
- livereload
- autoinject js/css in html

Install
------------

```bash
npm i -g grunt-cli
npm i -g coffee-script
npm i && bower i
```

Run
---

Developement version

```bash
grunt
```

Production version

```bash
grunt build
```

Deploy
------

```bash
heroku create your_app_name
git push heroku master
```

How to
-------------
- pngsprite@2x dimensions mist be placed in settings.styl