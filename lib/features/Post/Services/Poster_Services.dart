import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/features/Post/Model/Post_Model.dart';

final fetchPostData = StreamProvider<List<PostModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('poster')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => PostModel.fromSnapshot(snapshot))
          .toList());
  // return;
  yield* getData;
});
