// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'document.dart';

class DocumentBookmark {
  int? id;
  Document? document;

  DocumentBookmark({
    this.id,
    this.document,
  });

  DocumentBookmark.empty();

  DocumentBookmark copyWith({
    int? id,
    Document? document,
  }) {
    return DocumentBookmark(
      id: id ?? this.id,
      document: document ?? this.document,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'document': document?.toMap(),
    };
  }

  factory DocumentBookmark.fromMap(Map<String, dynamic> map) {
    return DocumentBookmark(
      id: map['id'] != null ? map['id'] as int : null,
      document: map['document'] != null
          ? Document.fromMap(map['document'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentBookmark.fromJson(String source) =>
      DocumentBookmark.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DocumentBookmark(id: $id, document: $document)';

  @override
  bool operator ==(covariant DocumentBookmark other) {
    if (identical(this, other)) return true;

    return other.id == id && other.document == document;
  }

  @override
  int get hashCode => id.hashCode ^ document.hashCode;
}
