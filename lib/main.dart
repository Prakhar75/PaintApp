import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyApp> {
  TextEditingController passController = new TextEditingController();

  Random rnd = new Random();
  double n;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/kira.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
        )),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
              ),
              FlatButton(
                onPressed: () {
                  print('pressed');
                  setState(() {
                    n = 15 + rnd.nextInt(25) + rnd.nextDouble();
                  });

                  final player = AudioCache();
                  player.play('mouseclick.mp3');
                },
                child: CircleAvatar(
                  child: Text(
                    'P',
                    style: TextStyle(
                      fontSize: n,
                      color: Colors.white,
                    ),
                  ),
                  radius: n,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'PRAKHAR  SHARMA',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Lobster',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FLUTTER  DEVELOPER',
                style: TextStyle(
                  color: Colors.teal.shade100,
                  fontSize: 15.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '19ucc106@lnmiit.ac.in',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    child: Theme(
                      data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Enter Email",
                                fillColor: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: passController,
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      ),
                    ),
                  )),
              MaterialButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('LOGIN'),
                onPressed: () => {
                  if ((passController.text) == 'Prakhar77')
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      ),
                    }
                  //  else
                  //  print invalid input on screen..
                },
                splashColor: Colors.tealAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WELCOME DRAW HERE"),
        ),
        body: Container(
          child: new GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                RenderBox object = context.findRenderObject();
                Offset _localposition =
                    object.globalToLocal(details.localPosition);
                _points = List.from(_points)..add(_localposition);
              });
            },
            onPanEnd: (DragEndDetails details) => _points.add(null),
            child: CustomPaint(
              painter: sign(points: _points),
              size: Size.infinite,
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.clear),
          onPressed: () => _points.clear(),
        ));
  }
}

class sign extends CustomPainter {
  List<Offset> points;
  sign({this.points});
  @override
  void paint(Canvas va, Size s) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    for (int i = 0; i < points.length; i++) {
      if (points[i] != null && points[i + 1] != null) {
        va.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(sign oldDelegate) => oldDelegate.points != points;
}
