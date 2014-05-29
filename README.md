:skull: GRUBOVO :skull:
=======================

Features
--------

Preprocessors:
- jade
- coffee
- stylus

Optimizations:
- concat
- uglify
- imgmin
- svgmin
- cssmin
- htmlmin

Tools:
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

Developement version:

```bash
grunt
```

Production version:

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

Icon font:
- add 'xxx.svg' to src/tools/iconfont/src/
- use 'i.fi.fi-xxx'

SVG sprite:
- add 'xxx.svg' to src/tools/svgsprite/src/
- use 'i.svg.svg-xxx' for sprite position
- use 'i.svg-xxx-dims' for default icon size

PNG sprite:
- add 'xxx.png' to src/tools/sprite/src/
- use 'i.i.i-xxx'

PNG sprite with retina support:
- add 'xxx.png' to src/tools/pngsprite/src/1x/
- add 'xxx@2x.png' to src/tools/pngsprite/src/2x/
- change $sprite-width and $sprite-height in src/stylus/settings.styl
- use 'i.png.png-xxx'
