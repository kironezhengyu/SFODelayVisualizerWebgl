<!DOCTYPE HTML>
<html lang="en">
  <head>
    <title>WebGL SFO Flights Delay Visualizer</title>
    <meta charset="utf-8">
    <style type="text/css">
      html {
        height: 100%;
      }
      body {
        margin: 0;
        padding: 0;
        background: #000000 url(loading.gif) center center no-repeat;
        color: #ffffff;
        font-family: sans-serif;
        font-size: 13px;
        line-height: 20px;
        height: 100%;
      }

      #info {

        font-size: 11px;
        position: absolute;
        bottom: 5px;
        background-color: rgba(0,0,0,0.8);
        border-radius: 3px;
        right: 10px;
        padding: 10px;

      }

      #currentInfo {
        width: 270px;
        position: absolute;
        left: 20px;
        top: 63px;

        background-color: rgba(0,0,0,0.2);

        border-top: 1px solid rgba(255,255,255,0.4);
        padding: 10px;
      }

      a {
        color: #aaa;
        text-decoration: none;
      }
      a:hover {
        text-decoration: underline;
      }

      .bull {
        padding: 0 5px;
        color: #555;
      }

      #title {
        position: absolute;
        top: 20px;
        width: 270px;
        left: 20px;
        background-color: rgba(0,0,0,0.2);
        border-radius: 3px;
        font: 20px Georgia;
        padding: 10px;
      }

      .year {
        font: 16px Georgia;
        line-height: 26px;
        height: 30px;
        text-align: center;
        float: left;
        width: 90px;
        color: rgba(255, 255, 255, 0.4);

        cursor: pointer;
        -webkit-transition: all 0.1s ease-out;
      }

      .year:hover, .year.active {
        font-size: 23px;
        color: #fff;
      }

      #ce span {
        display: none;
      }

      #ce {
        width: 107px;
        height: 55px;
        display: block;
        position: absolute;
        bottom: 15px;
        left: 20px;
        background: url(ce.png);
      }


    </style>
  </head>
  <body>

  <div id="container"></div>

  <div id="info">
    <strong><a href="http://www.chromeexperiments.com/globe">WebGL Globe</a></strong> <span class="bull">&bull;</span> Created by the Google Data Arts Team <span class="bull">&bull;</span> Data acquired from <a href="http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236">Bureau of Transportation</a>
  </div>

  <div id="currentInfo">
    <span id="year2013" class="year">2013</span>
    <span id="year2014" class="year">2014</span>
  </div>


  <div id="title">
    SFO Flights Delay Visualizer
  </div>

  <a id="ce" href="http://www.chromeexperiments.com/globe">
    <span>This is a Chrome Experiment</span>
  </a>

  <script type="text/javascript" src="third-party/Three/ThreeWebGL.js"></script>
  <script type="text/javascript" src="third-party/Three/ThreeExtras.js"></script>
  <script type="text/javascript" src="third-party/Three/RequestAnimationFrame.js"></script>
  <script type="text/javascript" src="third-party/Three/Detector.js"></script>
  <script type="text/javascript" src="third-party/Tween.js"></script>
  <script type="text/javascript" src="globe.js"></script>
  <script type="text/javascript">

    if(!Detector.webgl){
      Detector.addGetWebGLMessage();
    } else {

      var years = ['2013','2014'];
      var container = document.getElementById('container');
      var globe = new DAT.Globe(container);
      console.log(globe);
      var i, tweens = [];

      var settime = function(globe, t) {
        return function() {
          new TWEEN.Tween(globe).to({time: t/years.length},500).easing(TWEEN.Easing.Cubic.EaseOut).start();
          var y = document.getElementById('year'+years[t]);
          if (y.getAttribute('class') === 'year active') {
            return;
          }
          var yy = document.getElementsByClassName('year');
          console.log(yy);
          for(i=0; i<yy.length; i++) {
            yy[i].setAttribute('class','year');
          }
          y.setAttribute('class', 'year active');
        };
      };

      for(var i = 0; i<years.length; i++) {
        var y = document.getElementById('year'+years[i]);
        y.addEventListener('mouseover', settime(globe,i), false);
      }

      var xhr;
      TWEEN.start();


      xhr = new XMLHttpRequest();
      xhr.open('GET', '2013.json', true);
      xhr.onreadystatechange = function(e) {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            window.data = data;
            for (i=0;i<data.length;i++) {
              globe.addData(data[i][1], {format: 'magnitude', name: data[i][0], animated: true});
            }
            globe.createPoints();
            settime(globe,0)();
            globe.animate();
          }
        }
      };
      xhr.send(null);
    }

  </script>

  </body>

</html>
