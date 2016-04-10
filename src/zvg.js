// This defines a lot of globals, as properties on the window object,
// with accessor functions. This way, we're sure that we won't instantiate
// the Raphael paper object too soon.

(function() {
  var ZVG = {
    paper: () => new Raphael('paper'),

    pp: function() {
      return p => `${p[0]} ${p[1]} `;
    },

    cmd: function() {
      return ltr => R.concat(ltr + ' ');
    },

    M: function() {
      return cmd('M');
    },

    L: function() {
      return cmd('L');
    },

    Z: function() {
      return 'Z';
    },

    triangle: function() {
      return function(color, v0, v1, v2) {
        var path = M(pp(v0)) + 
          L(pp(v1)) + 
          L(pp(v2)) + 
          Z;
        var c = paper.path(path)
          .attr({
            fill: color
          });
      };
    },
  };


  var _cache = {};
  var propDesc = function(name) {
    return {
      enumerable: true,
      get: function() {
        if (typeof _cache[name] !== 'undefined') {
          return _cache[name];
        }
        var v = _cache[name] = ZVG[name]();
        return v;
      },
    };
  }
  Object.keys(ZVG).map(name => {
    Object.defineProperty(window, name, propDesc(name));
  });
})();

