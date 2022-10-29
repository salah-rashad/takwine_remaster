// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  int? id;
  String? title;
  List<String>? choices;
  String? answer;
  int? ordering;

  Question({
    this.id,
    this.title,
    this.choices,
    this.answer,
    this.ordering,
  });

  Question copyWith({
    int? id,
    String? title,
    List<String>? choices,
    String? answer,
    int? ordering,
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      choices: choices ?? this.choices,
      answer: answer ?? this.answer,
      ordering: ordering ?? this.ordering,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'choices': choices,
      'answer': answer,
      'ordering': ordering,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      choices:
          map['choices'] != null ? List<String>.from((map['choices'])) : null,
      answer: map['answer'] != null ? map['answer'] as String : null,
      ordering: map['ordering'] != null ? map['ordering'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, title: $title, choices: $choices, answer: $answer, ordering: $ordering)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.choices, choices) &&
        other.answer == answer &&
        other.ordering == ordering;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        choices.hashCode ^
        answer.hashCode ^
        ordering.hashCode;
  }
}
