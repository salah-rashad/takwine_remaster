// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../takwine_file.dart';

class LessonMaterial {
  int? id;
  String? title;
  String? content;
  int? lessonId;
  int? ordering;
  List<TakwineFile>? files;

  LessonMaterial({
    this.id,
    this.title,
    this.content,
    this.lessonId,
    this.ordering,
    required this.files,
  });

  LessonMaterial copyWith({
    int? id,
    String? title,
    String? content,
    int? lessonId,
    int? ordering,
    List<TakwineFile>? files,
  }) {
    return LessonMaterial(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      lessonId: lessonId ?? this.lessonId,
      ordering: ordering ?? this.ordering,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'lessonId': lessonId,
      'ordering': ordering,
      'files': files?.map((x) => x.toMap()).toList(),
    };
  }

  factory LessonMaterial.fromMap(Map<String, dynamic> map) {
    return LessonMaterial(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      lessonId: map['lessonId'] != null ? map['lessonId'] as int : null,
      ordering: map['ordering'] != null ? map['ordering'] as int : null,
      files: map['files'] != null
          ? List<TakwineFile>.from(
              (map['files'] as List<dynamic>).map<TakwineFile?>(
                (x) => TakwineFile.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonMaterial.fromJson(String source) =>
      LessonMaterial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LessonMaterial(id: $id, title: $title, content: $content, lessonId: $lessonId, ordering: $ordering, files: $files)';
  }

  @override
  bool operator ==(covariant LessonMaterial other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.lessonId == lessonId &&
        other.ordering == ordering &&
        listEquals(other.files, files);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        lessonId.hashCode ^
        ordering.hashCode ^
        files.hashCode;
  }
}
