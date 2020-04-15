import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              child: Text("Contact"),
              onPressed: (){
                Navigator.pushNamed(context, "/contact");
              }
            ),
            RaisedButton(
              child: Text("Services"),
              onPressed: (){
                Navigator.pushNamed(context, "/services");
              }
            )
          ],
        ),
      ),
    );
  }
}
