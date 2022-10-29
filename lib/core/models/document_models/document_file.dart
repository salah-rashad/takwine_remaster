// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentFile {
  int? id;
  int? documentId;
  String? name;
  String? date;
  String? description;
  String? file;
  String? docName;

  DocumentFile({
    this.id,
    this.documentId,
    this.name,
    this.date,
    this.description,
    this.file,
    this.docName,
  });

  DocumentFile copyWith({
    int? id,
    int? documentId,
    String? name,
    String? date,
    String? description,
    String? file,
    String? docName,
  }) {
    return DocumentFile(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      date: date ?? this.date,
      description: description ?? this.description,
      file: file ?? this.file,
      docName: docName ?? this.docName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'documentId': documentId,
      'name': name,
      'date': date,
      'description': description,
      'file': file,
      'docName': docName,
    };
  }

  factory DocumentFile.fromMap(Map<String, dynamic> map) {
    return DocumentFile(
      id: map['id'] != null ? map['id'] as int : null,
      documentId: map['documentId'] != null ? map['documentId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
      docName: map['docName'] != null ? map['docName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentFile.fromJson(String source) =>
      DocumentFile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentFile(id: $id, documentId: $documentId, name: $name, date: $date, description: $description, file: $file, docName: $docName)';
  }

  @override
  bool operator ==(covariant DocumentFile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.documentId == documentId &&
        other.name == name &&
        other.date == date &&
        other.description == description &&
        other.file == file &&
        other.docName == docName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        documentId.hashCode ^
        name.hashCode ^
        date.hashCode ^
        description.hashCode ^
        file.hashCode ^
        docName.hashCode;
  }
}
