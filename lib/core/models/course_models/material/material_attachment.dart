// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class MaterialAttachment {
//   int? id;
//   String? name;
//   String? url;
//   String? date;
//   int? materialId;

//   MaterialAttachment({
//     this.id,
//     this.name,
//     this.url,
//     this.date,
//     this.materialId,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'url': url,
//       'date': date,
//       'materialId': materialId,
//     };
//   }

//   factory MaterialAttachment.fromMap(Map<String, dynamic> map) {
//     return MaterialAttachment(
//       id: map['id'] != null ? map['id'] as int : null,
//       name: map['name'] != null ? map['name'] as String : null,
//       url: map['url'] != null ? map['url'] as String : null,
//       date: map['date'] != null ? map['date'] as String : null,
//       materialId: map['materialId'] != null ? map['materialId'] as int : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MaterialAttachment.fromJson(String source) =>
//       MaterialAttachment.fromMap(json.decode(source) as Map<String, dynamic>);

//   MaterialAttachment copyWith({
//     int? id,
//     String? name,
//     String? url,
//     String? date,
//     int? materialId,
//   }) {
//     return MaterialAttachment(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       url: url ?? this.url,
//       date: date ?? this.date,
//       materialId: materialId ?? this.materialId,
//     );
//   }

//   @override
//   String toString() {
//     return 'MaterialAttachment(id: $id, name: $name, url: $url, date: $date, materialId: $materialId)';
//   }

//   @override
//   bool operator ==(covariant MaterialAttachment other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.id == id &&
//       other.name == name &&
//       other.url == url &&
//       other.date == date &&
//       other.materialId == materialId;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       name.hashCode ^
//       url.hashCode ^
//       date.hashCode ^
//       materialId.hashCode;
//   }
// }
