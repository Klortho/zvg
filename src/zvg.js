
(function() {
  var paper = window.paper = new Raphael('paper');

  pp = p => `${p[0]} ${p[1]} `;
  cmd = ltr => R.concat(ltr + ' ');
  M = cmd('M');
  L = cmd('L');
  Z = 'Z';

  triangle = function(color, v0, v1, v2) {
    var path = M(pp(v0)) + 
      L(pp(v1)) + 
      L(pp(v2)) + 
      Z;
    var c = paper.path(path)
      .attr({
        fill: color
      });
  }
})();

