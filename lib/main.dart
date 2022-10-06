import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(primarySwatch: Colors.lightBlue),
    home: new MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation = animationController;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {
    showDatePicker(
        context: context,
        firstDate: new DateTime(1900),
        initialDate: new DateTime(2022),
        lastDate: DateTime.now()).then((DateTime dt) {
      selectedYear = dt.year;
      calculateAge();
    });
  }

  void calculateAge() {
    setState(() {
      age = (2022 - selectedYear).toDouble();
      animation = new Tween<double>(begin: animation.value, end: age).animate(
          new CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));

      animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator de varsta" ),),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            new OutlinedButton(
              child: new Text(selectedYear != null
                  ? selectedYear.toString()
                  : "Alege anul tau de nastere"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: _showPicker,
            ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            new AnimatedBuilder(
              animation: animation,
              builder: (context, child) => new Text(
                    "Ai ${animation.value.toStringAsFixed(0)} ani",
                    style: new TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
