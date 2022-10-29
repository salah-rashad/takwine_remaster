// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Certificate {
  int? id;
  int? userId;
  int? courseId;
  String? title;
  String? result;
  String? date;

  Certificate({
    this.id,
    this.userId,
    this.courseId,
    this.title,
    this.result,
    this.date,
  });

  Certificate copyWith({
    int? id,
    int? userId,
    int? courseId,
    String? title,
    String? result,
    String? date,
  }) {
    return Certificate(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      result: result ?? this.result,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'title': title,
      'result': result,
      'date': date,
    };
  }

  factory Certificate.fromMap(Map<String, dynamic> map) {
    return Certificate(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      courseId: map['courseId'] != null ? map['courseId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      result: map['result'] != null ? map['result'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Certificate.fromJson(String source) =>
      Certificate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Certificate(id: $id, userId: $userId, courseId: $courseId, title: $title, result: $result, date: $date)';
  }

  @override
  bool operator ==(covariant Certificate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.courseId == courseId &&
        other.title == title &&
        other.result == result &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        courseId.hashCode ^
        title.hashCode ^
        result.hashCode ^
        date.hashCode;
  }
}
