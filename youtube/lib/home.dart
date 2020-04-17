import 'package:flutter/material.dart';
import 'package:youtube/screens/home.dart';
import 'package:youtube/screens/library.dart';
import 'package:youtube/screens/subscriptions.dart';
import 'package:youtube/screens/trending.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomePage(),
      Trending(),
      Subscriptions(),
      Library()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: Image.asset("images/youtube.png", width: 98, height: 22),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              title: Text("Início"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Em alta"), icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(
              title: Text("Inscrições"), icon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(
              title: Text("Biblioteca"), icon: Icon(Icons.folder))
        ],
      ),
    );
  }
}
