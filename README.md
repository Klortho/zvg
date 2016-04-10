# Zombo Vector Graphics

Playing around with Ramda and Raphael.

Here's the [demo](https://nicolausmaloney.org/zvg/).

To include this in a jsfiddle, add this as an

Setup (do this once): `scripts/setup.sh`.

Build dist: `scripts/make.pl`.

See the [demo](https://zombom.github.io/zvg).

This also does an automatic deploy to the server whenever there's a
commit to master.

To publish manually:

```
scripts/make.pl
scripts/publish.sh
```

## To do

* Add to the publish hook a command to purge the cloudflare cache
  ([described
  here](https://www.cloudflare.com/a/caching/nicolausmaloney.org#purge_cache))
  