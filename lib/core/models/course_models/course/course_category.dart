// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseCategory {
  int? id;
  String? title;
  String? description;
  String? color;
  String? icon;
  
  CourseCategory({
    this.id,
    this.title,
    this.description,
    this.color,
    this.icon,
  });

  CourseCategory copyWith({
    int? id,
    String? title,
    String? description,
    String? color,
    String? icon,
  }) {
    return CourseCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'icon': icon,
    };
  }

  factory CourseCategory.fromMap(Map<String, dynamic> map) {
    return CourseCategory(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseCategory.fromJson(String source) =>
      CourseCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseCategory(id: $id, title: $title, description: $description, color: $color, icon: $icon)';
  }

  @override
  bool operator ==(covariant CourseCategory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.color == color &&
      other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      color.hashCode ^
      icon.hashCode;
  }
}
