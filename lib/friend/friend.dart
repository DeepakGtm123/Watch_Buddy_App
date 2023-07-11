import 'package:flutter/material.dart';

class Friend {
  String name;
  String details;

  Friend(this.name, this.details);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Friend> friends = [
    Friend("Friend 1", "Details of Friend 1"),
    Friend("Friend 2", "Details of Friend 2"),
    Friend("Friend 3", "Details of Friend 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friend List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Friend List'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  // Logic to invite friends goes here
                },
                child: Text('Invite Friends'),
              ),
              SizedBox(height: 16),
              Text(
                'Friends joined with me:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(friends[index].name),
                      subtitle: Text(friends[index].details),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
