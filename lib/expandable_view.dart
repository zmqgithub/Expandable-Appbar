import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ExpandableView extends StatefulWidget {
  ExpandedView expandedView = new ExpandedView();

  @override
  ExpandedView createState() => expandedView;
}

class ExpandedView extends State<ExpandableView>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  bool isTaped = false;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.000,
          0.800,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
  }

  void tappedEvent() {
    if (!isTaped) {
      controller.forward();
      isTaped = !isTaped;
    } else {
      controller.reverse();
      isTaped = !isTaped;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Material(
        elevation: 50.01,
        color: Colors.transparent,
        child: ClipPath(
          clipper: ArcClipper(),
          child: new Container(
            height: animation.value,
            decoration: new BoxDecoration(
                color: Colors.blue,
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.blueAccent],
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.circular(animation.value / 10))),
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(
                    Icons.expand_less,
                    color: Colors.white,
                    size: (animation.value / 300.0) * 50.0,
                  ),
                  Text(
                    'Click to minimize',
                    style: new TextStyle(
                        fontSize: (animation.value / 300.0) * 14.0,
                        color: Colors.white70),
                  ),
                  SizedBox(
                    height: (animation.value / 300.0) * 20.0,
                  ),
                  Text(
                    '\"A man\'s measure is his will.\"',
                    style: new TextStyle(
                        fontSize: (animation.value / 300.0) * 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        tappedEvent();
      },
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  // this class is copied from below url
  //https://flutter.rocks/2017/09/12/from-wireframes-to-flutter-movie-details-page/

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
