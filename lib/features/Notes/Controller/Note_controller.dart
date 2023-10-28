import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskplus/features/Notes/Model/S_Notes_Model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class NoteController {
  final todoCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('ShortNote');
  // create todo
  void addNewTask(NoteModel model) {
    todoCollection.add(model.toMap());
  }

  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
