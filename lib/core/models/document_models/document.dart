// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'document_category.dart';


class Document {
  int? id;
  String? title;
  DocumentCategory? category;
  String? image;
  String? date;

  Document({
    this.id,
    this.title,
    this.image,
    this.date,
  });

 

  Document copyWith({
    int? id,
    String? title,
    String? image,
    String? date,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'date': date,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Document(id: $id, title: $title, image: $image, date: $date)';
  }

  @override
  bool operator ==(covariant Document other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.image == image &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      image.hashCode ^
      date.hashCode;
  }
}
