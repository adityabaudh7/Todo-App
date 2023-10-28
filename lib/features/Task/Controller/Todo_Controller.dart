import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskplus/features/Task/model/todo_model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class TodoController {
  final todoCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('mytodo');
  // create todo
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  void updateTask(String? docID, bool? valueUpdae) {
    todoCollection.doc(docID).update({'isDone': valueUpdae});
  }

  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
