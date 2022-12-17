// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../helpers/constants/urls.dart';

class TakwineFile {
  int? id;
  String? name;
  String? extension;
  String? file;
  String? date;
  int? ordering;
  int? size;

  TakwineFile({
    this.id,
    this.name,
    this.extension,
    this.file,
    this.date,
    this.ordering,
    this.size,
  }) {
    if (file != null) {
      bool validURL = Uri.parse(file!).isAbsolute;

      if (!validURL) {
        file = Url.HOST_URI.replace(path: file!).toString();
      }
    }
  }

  TakwineFile copyWith({
    int? id,
    String? name,
    String? extension,
    String? file,
    String? date,
    int? ordering,
    int? size,
  }) {
    return TakwineFile(
      id: id ?? this.id,
      name: name ?? this.name,
      extension: extension ?? this.extension,
      file: file ?? this.file,
      date: date ?? this.date,
      ordering: ordering ?? this.ordering,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'extension': extension,
      'file': file,
      'date': date,
      'ordering': ordering,
      'size': size,
    };
  }

  factory TakwineFile.fromMap(Map<String, dynamic> map) {
    return TakwineFile(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      extension: map['extension'] != null ? map['extension'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      ordering: map['ordering'] != null ? map['ordering'] as int : null,
      size: map['size'] != null ? map['size'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TakwineFile.fromJson(String source) =>
      TakwineFile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TakwineFile(id: $id, name: $name, extension: $extension, file: $file, date: $date, ordering: $ordering, size: $size)';
  }

  @override
  bool operator ==(covariant TakwineFile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.extension == extension &&
        other.file == file &&
        other.date == date &&
        other.ordering == ordering &&
        other.size == size;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        extension.hashCode ^
        file.hashCode ^
        date.hashCode ^
        ordering.hashCode ^
        size.hashCode;
  }
}
