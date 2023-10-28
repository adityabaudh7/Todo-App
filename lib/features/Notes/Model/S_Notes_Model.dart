import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? docID;
  final String titleTask;
  final String disCription;
  final String createdNoteDate;

  NoteModel({
    required this.titleTask,
    required this.disCription,
    required this.createdNoteDate,
    this.docID,
  });

  Map<String, dynamic> toMap() {
    return {
      'docID': docID,
      'titleTask': titleTask,
      'disCription': disCription,
      'createdNoteDate': createdNoteDate
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        docID: map['docID'] != null ? map['docID'] as String : null,
        titleTask: map['titleTask'] as String,
        disCription: map['disCription'] as String,
        createdNoteDate: map['createdNoteDate'] as String);
  }

  // String toJson() => json.encode(toMap());

  // factory TodoModel.fromJson(String source) =>
  //     TodoModel.fromMap(json.decode(source));

  factory NoteModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return NoteModel(
      docID: doc.id,
      titleTask: doc['titleTask'],
      disCription: doc['disCription'],
      createdNoteDate: doc['createdNoteDate'],
    );
  }
}
