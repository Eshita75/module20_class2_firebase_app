import 'package:flutter/material.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index){
        return Card(
          child: Row(
            children: [
              Column(
                children: [
                  Text('1'),
                  Text('1'),
                  Text('1'),
                  Text('1'),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
