// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'question.dart';

class Exam {
  int? id;
  int? lesson;
  List<Question>? questions;

  Exam({
    this.id,
    this.lesson,
    this.questions,
  });

  Exam copyWith({
    int? id,
    int? lesson,
    List<Question>? questions,
  }) {
    return Exam(
      id: id ?? this.id,
      lesson: lesson ?? this.lesson,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lesson': lesson,
      'questions': questions?.map((x) => x.toMap()).toList(),
    };
  }

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      id: map['id'] != null ? map['id'] as int : null,
      lesson: map['lesson'] != null ? map['lesson'] as int : null,
      questions: map['questions'] != null
          ? List<Question>.from(
              (map['questions']).map<Question?>(
                (x) => Question.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exam.fromJson(String source) =>
      Exam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Exam(id: $id, lesson: $lesson, questions: $questions)';

  @override
  bool operator ==(covariant Exam other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.lesson == lesson &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode => id.hashCode ^ lesson.hashCode ^ questions.hashCode;
}
