// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../helpers/constants/urls.dart';
import '../takwine_file.dart';
import 'document_category.dart';

class Document {
  final int? id;
  final int? ordering;
  final String? title;
  String? imageUrl;
  final String? date;
  final bool? enabled;
  final String? content;
  final List<TakwineFile>? files;
  final DocumentCategory? category;

  Document({
    this.id,
    this.ordering,
    this.title,
    this.imageUrl,
    this.date,
    this.enabled,
    this.content,
    this.files,
    this.category,
  }) {
    if (imageUrl != null) {
      bool validURL = Uri.parse(imageUrl!).isAbsolute;

      if (!validURL) {
        imageUrl = Url.HOST_URI.replace(path: imageUrl!).toString();
      }
    }
  }

  Document copyWith({
    int? id,
    int? ordering,
    String? title,
    String? imageUrl,
    String? date,
    bool? enabled,
    String? content,
    List<TakwineFile>? files,
    DocumentCategory? category,
  }) {
    return Document(
      id: id ?? this.id,
      ordering: ordering ?? this.ordering,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      enabled: enabled ?? this.enabled,
      content: content ?? this.content,
      files: files ?? this.files,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ordering': ordering,
      'title': title,
      'imageUrl': imageUrl,
      'date': date,
      'enabled': enabled,
      'content': content,
      'files': files?.map((x) => x.toMap()).toList(),
      'category': category?.toMap(),
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] != null ? map['id'] as int : null,
      ordering: map['ordering'] != null ? map['ordering'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      enabled: map['enabled'] != null ? map['enabled'] as bool : null,
      content: map['content'] != null ? map['content'] as String : null,
      files: map['files'] != null
          ? List<TakwineFile>.from(
              (map['files'] as List<dynamic>).map<TakwineFile?>(
                (x) => TakwineFile.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      category: map['category'] != null
          ? DocumentCategory.fromMap(map['category'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Document(id: $id, ordering: $ordering, title: $title, imageUrl: $imageUrl, date: $date, enabled: $enabled, content: $content, files: $files, category: $category)';
  }

  @override
  bool operator ==(covariant Document other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ordering == ordering &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.date == date &&
        other.enabled == enabled &&
        other.content == content &&
        listEquals(other.files, files) &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ordering.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        date.hashCode ^
        enabled.hashCode ^
        content.hashCode ^
        files.hashCode ^
        category.hashCode;
  }
}
