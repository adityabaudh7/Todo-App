// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/features/Notes/Model/S_Notes_Model.dart';
import 'package:taskplus/features/Task/Controller/Todo_Controller.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

final servicesProvider = StateProvider<TodoController>((ref) {
  return TodoController();
});

final fetchNoteData = StreamProvider<List<NoteModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('ShortNote')
      .orderBy('createdNoteDate', descending: false)
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => NoteModel.fromSnapshot(snapshot))
          .toList());
  // return;
  yield* getData;
});
