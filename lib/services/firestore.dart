import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // CREATE

  Future<void> addNote(String note){
    return notes.add({
      'note':note,
      'timestamp':Timestamp.now(),

    });
  }

}