// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Auth/Model/User_model.dart';
import 'package:taskplus/features/Task/model/todo_model.dart';
import 'package:taskplus/features/Task/Controller/Todo_Controller.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

final servicesProvider = StateProvider<TodoController>((ref) {
  return TodoController();
});

final fetchData = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('mytodo')
      .orderBy('dateTask', descending: false)
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  // return;
  yield* getData;
});

final CompletedTasksProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('mytodo')
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map((event) => event.docs
            .map((snapshot) => TodoModel.fromSnapshot(snapshot))
            .toList());
    yield* query;
  }
});

final pendingTasksProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final query = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('mytodo')
        .where('isDone', isEqualTo: false) // Filter pending tasks
        .snapshots()
        .map((event) => event.docs
            .map((snapshot) => TodoModel.fromSnapshot(snapshot))
            .toList());
    yield* query;
  }
});

// getuser data
final getUserData = StreamProvider<UserModel?>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) =>
            UserModel.fromMap(snapshot.data() as Map<String, dynamic>));
  }
  return Stream.value(null);
});

// for dartk mode
final darkModeProvider = StateProvider<bool>((ref) {
  return false;
});
