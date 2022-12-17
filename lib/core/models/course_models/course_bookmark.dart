// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'course/course.dart';

class CourseBookmark {
  int? id;
  Course? course;

  CourseBookmark({
    this.id,
    this.course,
  });

  CourseBookmark.empty();

  CourseBookmark copyWith({
    int? id,
    Course? course,
  }) {
    return CourseBookmark(
      id: id ?? this.id,
      course: course ?? this.course,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'course': course?.toMap(),
    };
  }

  factory CourseBookmark.fromMap(Map<String, dynamic> map) {
    return CourseBookmark(
      id: map['id'] != null ? map['id'] as int : null,
      course: map['course'] != null
          ? Course.fromMap(map['course'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseBookmark.fromJson(String source) =>
      CourseBookmark.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CourseBookmark(id: $id, course: $course)';

  @override
  bool operator ==(covariant CourseBookmark other) {
    if (identical(this, other)) return true;

    return other.id == id && other.course == course;
  }

  @override
  int get hashCode => id.hashCode ^ course.hashCode;
}
