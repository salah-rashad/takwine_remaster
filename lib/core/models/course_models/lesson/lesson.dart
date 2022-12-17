// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum LessonStatus {
  NONE,
  InProgress,
  Complete,
  Locked,
}

class Lesson {
  int? id;
  int? course;
  String? title;
  String? description;
  int? ordering;
  int? days;
  int? totalMaterialsCount;
  bool? isComplete;
  double? result;
  LessonStatus status = LessonStatus.NONE;

  Lesson({
    this.id,
    this.course,
    this.title,
    this.description,
    this.ordering,
    this.days,
    this.totalMaterialsCount,
    this.isComplete,
    this.result,
  });

  Lesson copyWith({
    int? id,
    int? course,
    String? title,
    String? description,
    int? ordering,
    int? days,
    int? totalMaterialsCount,
    bool? isComplete,
    double? result,
  }) {
    return Lesson(
      id: id ?? this.id,
      course: course ?? this.course,
      title: title ?? this.title,
      description: description ?? this.description,
      ordering: ordering ?? this.ordering,
      days: days ?? this.days,
      totalMaterialsCount: totalMaterialsCount ?? this.totalMaterialsCount,
      isComplete: isComplete ?? this.isComplete,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'course': course,
      'title': title,
      'description': description,
      'ordering': ordering,
      'days': days,
      'totalMaterialsCount': totalMaterialsCount,
      'isComplete': isComplete,
      'result': result,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] != null ? map['id'] as int : null,
      course: map['course'] != null ? map['course'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      ordering: map['ordering'] != null ? map['ordering'] as int : null,
      days: map['days'] != null ? map['days'] as int : null,
      totalMaterialsCount: map['totalMaterialsCount'] != null
          ? map['totalMaterialsCount'] as int
          : null,
      isComplete: map['isComplete'] != null ? map['isComplete'] as bool : null,
      result: map['result'] != null ? map['result'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) =>
      Lesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lesson(id: $id, course: $course, title: $title, description: $description, ordering: $ordering, days: $days, totalMaterialsCount: $totalMaterialsCount, isComplete: $isComplete, result: $result)';
  }

  @override
  bool operator ==(covariant Lesson other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.course == course &&
        other.title == title &&
        other.description == description &&
        other.ordering == ordering &&
        other.days == days &&
        other.totalMaterialsCount == totalMaterialsCount &&
        other.isComplete == isComplete &&
        other.result == result;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        course.hashCode ^
        title.hashCode ^
        description.hashCode ^
        ordering.hashCode ^
        days.hashCode ^
        totalMaterialsCount.hashCode ^
        isComplete.hashCode ^
        result.hashCode;
  }
}
