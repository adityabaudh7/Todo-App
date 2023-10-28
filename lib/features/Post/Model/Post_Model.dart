import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String quote;
  final String author;
  final String image;
  PostModel({
    required this.quote,
    required this.author,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
      'image': image,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      quote: map['quote'] as String,
      author: map['author'] as String,
      image: map['image'],
    );
  }

  factory PostModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return PostModel(
      quote: doc['quote'],
      author: doc['author'],
      image: doc['image'],
    );
  }
}
