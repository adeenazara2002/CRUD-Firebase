import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // open a dialog box to add a note

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes'),),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child: const Icon(Icons.add),),
    );
  }
}