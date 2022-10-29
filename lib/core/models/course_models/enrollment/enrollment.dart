// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../lesson/lesson.dart';
import '../course/course.dart';

class Enrollment {
  int? id;
  Course? course;
  Lesson? currentLesson;
  double? progress;
  bool? isComplete;

  Enrollment({
    this.id,
    this.course,
    this.currentLesson,
    this.progress,
    this.isComplete,
  });

  Enrollment copyWith({
    int? id,
    Course? course,
    Lesson? currentLesson,
    double? progress,
    bool? isComplete,
  }) {
    return Enrollment(
      id: id ?? this.id,
      course: course ?? this.course,
      currentLesson: currentLesson ?? this.currentLesson,
      progress: progress ?? this.progress,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'course': course?.toMap(),
      'currentLesson': currentLesson?.toMap(),
      'progress': progress,
      'isComplete': isComplete,
    };
  }

  factory Enrollment.fromMap(Map<String, dynamic> map) {
    return Enrollment(
      id: map['id'] != null ? map['id'] as int : null,
      course: map['course'] != null ? Course.fromMap(map['course'] as Map<String,dynamic>) : null,
      currentLesson: map['currentLesson'] != null ? Lesson.fromMap(map['currentLesson'] as Map<String,dynamic>) : null,
      progress: map['progress'] != null ? map['progress'] as double : null,
      isComplete: map['isComplete'] != null ? map['isComplete'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enrollment.fromJson(String source) =>
      Enrollment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Enrollment(id: $id, course: $course, currentLesson: $currentLesson, progress: $progress, isComplete: $isComplete)';
  }

  @override
  bool operator ==(covariant Enrollment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.course == course &&
      other.currentLesson == currentLesson &&
      other.progress == progress &&
      other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      course.hashCode ^
      currentLesson.hashCode ^
      progress.hashCode ^
      isComplete.hashCode;
  }
}
