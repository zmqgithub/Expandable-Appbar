import 'package:flutter/material.dart';
import 'expandable_view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Floating Appbar',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(title: 'Floating Appbar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ExpandableView expandableView = new ExpandableView();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.expand_more), onPressed: () {
            expandableView.expandedView.tappedEvent();
          })
        ],
      ),
      backgroundColor: Colors.lightBlue[50],
      body: new Stack(
        fit: StackFit.expand,
          children: <Widget>[
            new Container(
              color: Colors.lightBlue[50],
              child: new Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.expand_more,size: 50.0, color: Colors.grey,),
                  new SizedBox(height: 20.0,),
                  new Text('Press expand button in appbar', style: new TextStyle(color: Colors.black87),),
                  new SizedBox(height: 20.0,),
                  new Container(padding: new EdgeInsets.all(10.0),
                    child: new Text('\"Do not talk about knowledge with the foolish so that they deny you, nor with the ignorant so that they find you oppressive, but talk about it with those of its people whom you meet who will accept it and understand it.\"',
                      style: new TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic,color: Colors.grey),textAlign: TextAlign.center,
                    ),)
//                  new Text('Gufra', style: new TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.blue.withOpacity(0.1)),)
                ],
              ),
            ),
            new Column(
              children: <Widget>[expandableView],
            )
          ]
      ),
    );
  }
}
