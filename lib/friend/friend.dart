import 'package:flutter/material.dart';

class Friend {
  String name;
  String details;

  Friend(this.name, this.details);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
          title: const Text('Friend List'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  // Logic to invite friends goes here
                },
                child: const Text('Invite Friends'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Friends joined with me:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
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

RaisedButton({required Null Function() onPressed, required Text child}) {
}