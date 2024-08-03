import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/services/firestore.dart';
//  import 'package:crudfirebase/pages/home_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // firestore

  final FireStoreService fireStoreService = FireStoreService();

  // textcontroller

  final TextEditingController textController = TextEditingController();

  // open a dialog box to add a note
  void openNoteBox({String? docId}){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: TextField(
        controller: textController,
      ),
      actions: [
        // button to save
        ElevatedButton(onPressed: (){
          // add a new note
          if (docId == null) {
          fireStoreService.addNote(textController.text);
                        
          }

          // update an existing note
          else{
            fireStoreService.updateNote(docId, textController.text);
          }

          // clear the text controller 
          textController.clear();

          //close the box

          Navigator.pop(context);


        }, 
        child: Text('Add')
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: openNoteBox,
      child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context,snapshot){
          // if we have data get all

          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as list

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context , index)
            {
              // get individual doc

              DocumentSnapshot document = notesList[index];
              String docId = document.id;

              // get notes from each document
              Map<String , dynamic> data = document.data() as Map<String, dynamic>;
              String noteText = data['note'];

              // display as a listTile

              return ListTile(
                title: Text('NoteText'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // update
                    IconButton(onPressed: () => openNoteBox(docId: docId), 
                icon: const Icon(Icons.settings)
                ),

                // delete

                IconButton(onPressed: () => fireStoreService.deleteNote(docId), 
                icon: const Icon(Icons.delete),
                ),
                  ],
                )
              );
            }
            );
          }

          // if there is no data
          else{
            return const Text('no notes...');
          }
        }
      ),
    );
  }
}