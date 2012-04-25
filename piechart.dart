// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#library('sunflower');

#import('dart:html');

#resource('sunflower.css');

main() {
  new Sunflower();
}

class Sunflower{
  
  Sunflower() {
    COLORS = [ "blue",
              "yellow",
              "red",
              "green",
              "orange",
              "brown",
              "aqua",
              "grey",
              "violet",
              "wheat",
              "salmon",
              "magenta",
              "lime",
              "maroon",
              "crimson"
              ];
    
    xc = yc = MAX_D / 2;
    
    PHI = (Math.sqrt(5) + 1) / 2;
    
    CanvasElement canvas = document.query("#canvas");
    xc = yc = MAX_D / 2;
    ctx = canvas.getContext("2d");
    
    var costs = {
                 "requirements" : 35,
                 "planning" : 45,
                 "documentation" : 10,
                 "requirement gathering" : 23,
                 "development" : 50,
                 "testing" : 20,
                 "deployement" : 13,
                 "sales" : 46,
                 "maintenance" : 60,
    };
    
    drawPieChart( costs );
  }

  drawPieChart( Map m ){
    var values = m.getValues();
    num tot = 0;
    values.forEach( (v) => (tot += (v)) );
    tot /= 2;
    var curAngle = 0;
    var totAngle = 0;
    num i = 0;
    var pieText;
    
    m.forEach((k,v){
      curAngle = Math.PI * v / tot;
      drawPie(totAngle, totAngle + curAngle, COLORS[i++] );
      pieText = (v/tot*50).toStringAsFixed(1);
      placeText( "$k $pieText%", totAngle + curAngle / 2 );
      
      totAngle += curAngle;
    } );
  }
  
  // Draw a small circle representing a seed centered at (x,y).
  void drawPie(num startAngle, num endAngle, String color) {
    ctx.beginPath();
    ctx.lineWidth = 1;
    ctx.fillStyle = color;
    ctx.strokeStyle = "white";
    ctx.arc(xc, yc, RADIUS, startAngle, endAngle, false);
    ctx.lineTo(xc, yc);
    ctx.fill();
    ctx.closePath();
    ctx.stroke();
   
  }
  
  void placeText( String str, num angle ){
    ctx.fillStyle = "black";
    num x = Math.cos(angle) * (RADIUS+5) + xc ;
    num y = Math.sin(angle) * (RADIUS+5) + yc ;
    
    if( x < xc ){
      x -= str.length * 5.2;
    }
    if( y > yc ){
      y += 5 ;
    }
    white
    ctx.fillText(str, x, y);
  }

  CanvasRenderingContext2D ctx;
  num xc, yc;
  num seeds = 0;

  static final RADIUS = 120;
  static final SCALE_FACTOR = 4;
  static final TAU = Math.PI * 2;
  var PHI;
  static final MAX_D = 500;
  var COLORS;

}
