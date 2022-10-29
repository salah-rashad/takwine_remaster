// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompleteLesson {
  int? lesson;
  double? result;
  
  CompleteLesson({
    this.lesson,
    this.result,
  });

  CompleteLesson copyWith({
    int? lesson,
    double? result,
  }) {
    return CompleteLesson(
      lesson: lesson ?? this.lesson,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lesson': lesson,
      'result': result,
    };
  }

  factory CompleteLesson.fromMap(Map<String, dynamic> map) {
    return CompleteLesson(
      lesson: map['lesson'] != null ? map['lesson'] as int : null,
      result: map['result'] != null ? map['result'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompleteLesson.fromJson(String source) =>
      CompleteLesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompleteLesson(lesson: $lesson, result: $result)';

  @override
  bool operator ==(covariant CompleteLesson other) {
    if (identical(this, other)) return true;

    return other.lesson == lesson && other.result == result;
  }

  @override
  int get hashCode => lesson.hashCode ^ result.hashCode;
}
