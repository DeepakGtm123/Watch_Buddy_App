import 'package:flutter/material.dart';
// import 'package: chat/ChatMessageListen.dart';
// import 'package: chat/ChatScreen.dart';
// import 'package: friend/friend.dart';
// import 'package: home/home.dart';
// import 'package: login/global.dart';
// import 'package: login/login.dart';
// import 'package: login/signup.dart';
// import 'package: video/videoplayer.dart';


void main() {
  runApp(WatchBuddy());
}

class WatchBuddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WATCH BUDDY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pageOptions = <Widget>[
    Text('Home Page'),
    Text('Friends Page'),
    Text('Play Video Page'),
    Text('Chat Page'),
    Text('Signup Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WATCH BUDDY'),
      ),
      body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Colors.blue),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled, color: Colors.blue),
            label: 'Play Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.blue),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add, color: Colors.blue),
            label: 'Signup',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
