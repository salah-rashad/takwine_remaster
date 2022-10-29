// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rating {
  int? id;
  int? courseId;
  double? rate;
  String? comment;
  String? date;
  String? userId;
  String? userFirstName;
  String? userLastName;
  String? userImage;
  
  Rating({
    this.id,
    this.courseId,
    this.rate,
    this.comment,
    this.date,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.userImage,
  });

  

  Rating copyWith({
    int? id,
    int? courseId,
    double? rate,
    String? comment,
    String? date,
    String? userId,
    String? userFirstName,
    String? userLastName,
    String? userImage,
  }) {
    return Rating(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      rate: rate ?? this.rate,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'rate': rate,
      'comment': comment,
      'date': date,
      'userId': userId,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userImage': userImage,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id'] != null ? map['id'] as int : null,
      courseId: map['courseId'] != null ? map['courseId'] as int : null,
      rate: map['rate'] != null ? map['rate'] as double : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      userFirstName: map['userFirstName'] != null ? map['userFirstName'] as String : null,
      userLastName: map['userLastName'] != null ? map['userLastName'] as String : null,
      userImage: map['userImage'] != null ? map['userImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rating(id: $id, courseId: $courseId, rate: $rate, comment: $comment, date: $date, userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, userImage: $userImage)';
  }

  @override
  bool operator ==(covariant Rating other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.courseId == courseId &&
      other.rate == rate &&
      other.comment == comment &&
      other.date == date &&
      other.userId == userId &&
      other.userFirstName == userFirstName &&
      other.userLastName == userLastName &&
      other.userImage == userImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      courseId.hashCode ^
      rate.hashCode ^
      comment.hashCode ^
      date.hashCode ^
      userId.hashCode ^
      userFirstName.hashCode ^
      userLastName.hashCode ^
      userImage.hashCode;
  }
}
