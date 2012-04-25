// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#library('sunflower');

#import('dart:html');

#resource('sunflower.css');

runRand(Sunflower sf){  
  var myMap = {
               "requirements" : Math.random()*100,
               "planning" : Math.random()*100,
               "documentation" : Math.random()*100,
               "requirement gathering" : Math.random()*100,
               "development" : Math.random()*100,
               "testing" : Math.random()*100,
               "deployement" : Math.random()*100,
               "sales" : Math.random()*100,
               "maintenance" : Math.random()*100,
  };
  sf.morphGraph(myMap);
  
  window.setInterval(f() => runRand(sf), 7000);
}

main() {
  var sf = new Sunflower();
  runRand(sf);
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
    
    xc = MAX_X / 2;
    yc = MAX_Y / 2;
    
    PHI = (Math.sqrt(5) + 1) / 2;
    
    CanvasElement canvas = document.query("#canvas");

    ctx = canvas.getContext("2d");
    
    myMap = {
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
    
    drawAxes(1, 1, 1, 1);
    drawBarChart( myMap );
  }
  
  drawAxes(num minX, num maxX, num minY, num maxY){
    ctx.strokeStyle = "black";
    ctx.lineWidth = 2;
    
    ctx.moveTo(20, 20);
    ctx.lineTo(20, MAX_Y - 20);
    ctx.lineTo(MAX_X - 20, MAX_Y -  20);
    ctx.stroke();
  }

  drawBarChart( Map m ){
    var values = m.getValues();
    num max = 0;
    values.forEach( (v) => (max = ((v>max) ? v : max)) );

    num height = 0;
    num width = (MAX_X - 100) / m.length ;
    num curPos = 0;
    num i = 0;
    var pieText;
    
    m.forEach((k,v){
      height = (v / max) * (MAX_Y - 100);
      drawBar(curPos, width, (MAX_Y - 100), "white");
      drawBar(curPos, width, height, COLORS[i]);
      curPos += width;
      i++;
    } );
    
    curPos = 0;
    i = 0;

    ctx.translate(0, 500);
    ctx.rotate(-(Math.PI/2));
    ctx.scale(1.6, 1.6);
    ctx.fillStyle = "black";
    
    m.forEach((k,v){      
      ctx.fillText("$k", 28, curPos + width/3 + 13);
      curPos += width/1.6;
    } );
    
    ctx.scale(0.625, 0.625);
    ctx.rotate((Math.PI/2));
    ctx.translate(0, -500);   
  }
  
  morphGraph( Map m, [num counter = 20] ){
    var m1Vals = m.getValues();
    var m2Vals = myMap.getValues();
    var i;    
    var flag = false;
    
    for( i = 0 ; i < m1Vals.length ; i++ ){
      if( m1Vals[i] < m2Vals[i] ){
        
        m2Vals[i]-=2;
          flag = true;
      } else if( m1Vals[i] > m2Vals[i] ){
        
        m2Vals[i]+=2;
          flag = true;
      }
    }
    
    i = 0;
    myMap.forEach((k,v){
      myMap[k] = m2Vals[i];
      i++;
    } );
    
    drawBarChart( myMap );
    if( counter-- > 0 && flag ){
      window.setInterval(f() => morphGraph(m, counter), 200);
    }
  }
  
  // Draw a small circle representing a seed centered at (x,y).
  void drawBar(num x, num width, num height, String color) {
    x += 21;
    num y = MAX_Y - 21 - height;
    ctx.lineWidth = 1;
    ctx.fillStyle = color;
    ctx.strokeStyle = "white";
    ctx.fillRect(x, y, width, height);
    ctx.strokeRect(x, y, width, height);
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
    
    ctx.fillText(str, x, y);
  }

  CanvasRenderingContext2D ctx;
  num xc, yc;
  num seeds = 0;

  static final RADIUS = 120;
  static final SCALE_FACTOR = 4;
  static final TAU = Math.PI * 2;
  var PHI;
  static final MAX_X = 700;
  static final MAX_Y = 500;
  var COLORS;
  Map myMap;
}
