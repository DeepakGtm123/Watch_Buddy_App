import 'package:flutter/material.dart';

//importing other files in main.dart file
import 'chat/ChatMessageListen.dart';
import 'chat/ChatScreen.dart';
import 'friend/friend.dart';
import 'home/home.dart';
import 'login/global.dart';
import 'login/login.dart';
import 'login/signup.dart';
import 'video/videoplayer.dart';

void main() {
  runApp(const WatchBuddy());
}

class WatchBuddy extends StatelessWidget {
  const WatchBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WATCH BUDDY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pageOptions = <Widget>[
    const Text('Home Page'),
    const Text('Friends Page'),
    const Text('Play Video Page'),
    const Text('Chat Page'),
    const Text('Signup Page'),
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
        title: const Text('WATCH BUDDY'),
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
            label: 'SignUp',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
