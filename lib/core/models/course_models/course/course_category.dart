// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseCategory {
  int? id;
  String? title;
  String? description;
  String? color;
  String? iconUrl;
  String? type;

  CourseCategory({
    this.id,
    this.title,
    this.description,
    this.color,
    this.iconUrl,
    this.type,
  });

  CourseCategory copyWith({
    int? id,
    String? title,
    String? description,
    String? color,
    String? iconUrl,
    String? type,
  }) {
    return CourseCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      iconUrl: iconUrl ?? this.iconUrl,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'iconUrl': iconUrl,
      'type': type,
    };
  }

  factory CourseCategory.fromMap(Map<String, dynamic> map) {
    return CourseCategory(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      iconUrl: map['iconUrl'] != null ? map['iconUrl'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseCategory.fromJson(String source) =>
      CourseCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseCategory(id: $id, title: $title, description: $description, color: $color, iconUrl: $iconUrl, type: $type)';
  }

  @override
  bool operator ==(covariant CourseCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.color == color &&
        other.iconUrl == iconUrl &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        color.hashCode ^
        iconUrl.hashCode ^
        type.hashCode;
  }
}
