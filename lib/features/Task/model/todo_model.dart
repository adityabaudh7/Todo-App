import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String titleTask;
  final String disCription;
  final String cateogry;
  final String dateTask;
  final String startTimeTask;
  final String endTimeTask;
  final String reminderTask;
  final String repeatTask;
  final bool isDone;
  TodoModel({
    required this.titleTask,
    required this.disCription,
    required this.cateogry,
    required this.dateTask,
    required this.startTimeTask,
    required this.endTimeTask,
    required this.repeatTask,
    required this.reminderTask,
    required this.isDone,
    this.docID,
  });

  Map<String, dynamic> toMap() {
    return {
      'docID': docID,
      'titleTask': titleTask,
      'disCription': disCription,
      'cateogry': cateogry,
      'dateTask': dateTask,
      'startTimeTask': startTimeTask,
      'endTimeTask': endTimeTask,
      'repeatTask': repeatTask,
      'reminderTask': reminderTask,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleTask: map['titleTask'] as String,
      disCription: map['disCription'] as String,
      cateogry: map['cateogry'] as String,
      dateTask: map['dateTask'] as String,
      startTimeTask: map['startTimeTask'] as String,
      endTimeTask: map['endTimeTask'] as String,
      repeatTask: map['repeatTask'] as String,
      reminderTask: map['reminderTask'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory TodoModel.fromJson(String source) =>
  //     TodoModel.fromMap(json.decode(source));

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
        docID: doc.id,
        titleTask: doc['titleTask'],
        disCription: doc['disCription'],
        cateogry: doc['cateogry'],
        dateTask: doc['dateTask'],
        startTimeTask: doc['startTimeTask'],
        endTimeTask: doc['endTimeTask'],
        repeatTask: doc['repeatTask'],
        reminderTask: doc['reminderTask'],
        isDone: doc['isDone']);
  }
}
