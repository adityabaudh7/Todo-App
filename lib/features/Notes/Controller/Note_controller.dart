import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskplus/features/Notes/Model/S_Notes_Model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class NoteController {
  final noteCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('ShortNote');
  // create notes
  void addNewNote(NoteModel model) {
    noteCollection.add(model.toMap());
  }

  void updateTask(String? docID, String? noteTitle, String? noteDiscreptions) {
    noteCollection
        .doc(docID)
        .update({'titleTask': noteTitle, 'disCription': noteDiscreptions});
  }

  void deleteTask(String? docID) {
    noteCollection.doc(docID).delete();
  }
}
