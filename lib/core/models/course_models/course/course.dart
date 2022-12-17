// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../helpers/constants/urls.dart';
import '../../takwine_file.dart';
import 'course_category.dart';

class Course {
  final int? id;
  final String? title;
  final String? description;
  final CourseCategory? category;
  String? imageUrl;
  final TakwineFile? guideFile;
  final String? videoUrl;
  final String? date;
  final bool? enabled;
  final double? rate;
  final int? days;
  final int? totalEnrollments;

  Course({
    this.id,
    this.title,
    this.description,
    this.category,
    this.imageUrl,
    this.guideFile,
    this.videoUrl,
    this.date,
    this.enabled,
    this.rate,
    this.days,
    this.totalEnrollments,
  }) {
    if (imageUrl != null) {
      bool validURL = Uri.parse(imageUrl!).isAbsolute;

      if (!validURL) {
        imageUrl = Url.HOST_URI.replace(path: imageUrl!).toString();
      }
    }
  }

  Course copyWith({
    int? id,
    String? title,
    String? description,
    CourseCategory? category,
    String? imageUrl,
    TakwineFile? guideFile,
    String? videoUrl,
    String? date,
    bool? enabled,
    double? rate,
    int? days,
    int? totalEnrollments,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      guideFile: guideFile ?? this.guideFile,
      videoUrl: videoUrl ?? this.videoUrl,
      date: date ?? this.date,
      enabled: enabled ?? this.enabled,
      rate: rate ?? this.rate,
      days: days ?? this.days,
      totalEnrollments: totalEnrollments ?? this.totalEnrollments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category?.toMap(),
      'imageUrl': imageUrl,
      'guideFile': guideFile?.toMap(),
      'videoUrl': videoUrl,
      'date': date,
      'enabled': enabled,
      'rate': rate,
      'days': days,
      'totalEnrollments': totalEnrollments,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null
          ? CourseCategory.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      guideFile: map['guideFile'] != null
          ? TakwineFile.fromMap(map['guideFile'] as Map<String, dynamic>)
          : null,
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      enabled: map['enabled'] != null ? map['enabled'] as bool : null,
      rate: map['rate'] != null ? map['rate'] as double : null,
      days: map['days'] != null ? map['days'] as int : null,
      totalEnrollments: map['totalEnrollments'] != null
          ? map['totalEnrollments'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(id: $id, title: $title, description: $description, category: $category, imageUrl: $imageUrl, guideFile: $guideFile, videoUrl: $videoUrl, date: $date, enabled: $enabled, rate: $rate, days: $days, totalEnrollments: $totalEnrollments)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.imageUrl == imageUrl &&
        other.guideFile == guideFile &&
        other.videoUrl == videoUrl &&
        other.date == date &&
        other.enabled == enabled &&
        other.rate == rate &&
        other.days == days &&
        other.totalEnrollments == totalEnrollments;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        imageUrl.hashCode ^
        guideFile.hashCode ^
        videoUrl.hashCode ^
        date.hashCode ^
        enabled.hashCode ^
        rate.hashCode ^
        days.hashCode ^
        totalEnrollments.hashCode;
  }

  // double calculateRating() {
  //   if (rating == null || sumRate == null) return 0.0;
  //   num mRating = num.parse(rating!);
  //   num mSumRate = num.parse(sumRate!);

  //   final equation = (mRating / mSumRate) / 20;

  //   if (equation.isNaN || equation.isNegative) return 0.0;

  //   return equation;
  // }
}
