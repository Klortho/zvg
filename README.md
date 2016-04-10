# Zombo Vector Graphics

Playing around with Ramda and Raphael, to make a more functional-programming
style library for SVG.

See the [demo](https://nicolausmaloney.org/zvg/) (not much yet).

To include this in a jsfiddle, add this as an external resource:

    https://nicolausmaloney.org/zvg/zvg-bundle.js

Or just fork [this one](https://jsfiddle.net/klortho/mr3omt5b/1/).


## Development

*[This is very primitive now. I would like to use webpack for it.]*

Setup (do this once): `scripts/setup.sh`.

Build the dist: `scripts/make.pl`.

This also does an automatic deploy to the server whenever there's a
commit to master.

To deploy manually:

```
scripts/make.pl
scripts/deploy.sh
```

## To do

* Add, to the deploy hook, a command to purge the cloudflare cache
  ([described
  here](https://www.cloudflare.com/a/caching/nicolausmaloney.org#purge_cache))
