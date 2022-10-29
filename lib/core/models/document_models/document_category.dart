// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentCategory {
  int? id;
  String? title;
  String? description;
  String? color;
  String? icon;
  
  DocumentCategory({
    this.id,
    this.title,
    this.description,
    this.color,
    this.icon,
  });

  DocumentCategory copyWith({
    int? id,
    String? title,
    String? description,
    String? color,
    String? icon,
  }) {
    return DocumentCategory(
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

  factory DocumentCategory.fromMap(Map<String, dynamic> map) {
    return DocumentCategory(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentCategory.fromJson(String source) =>
      DocumentCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentCategory(id: $id, title: $title, description: $description, color: $color, icon: $icon)';
  }

  @override
  bool operator ==(covariant DocumentCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
