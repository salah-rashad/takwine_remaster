// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class MaterialComponent {
//   int? id;
//   String? type;
//   String? data;
//   String? materialId;

//   MaterialComponent({
//     this.id,
//     this.type,
//     this.data,
//     this.materialId,
//   });

//   MaterialComponent copyWith({
//     int? id,
//     String? type,
//     String? data,
//     String? materialId,
//   }) {
//     return MaterialComponent(
//       id: id ?? this.id,
//       type: type ?? this.type,
//       data: data ?? this.data,
//       materialId: materialId ?? this.materialId,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'type': type,
//       'data': data,
//       'materialId': materialId,
//     };
//   }

//   factory MaterialComponent.fromMap(Map<String, dynamic> map) {
//     return MaterialComponent(
//       id: map['id'] != null ? map['id'] as int : null,
//       type: map['type'] != null ? map['type'] as String : null,
//       data: map['data'] != null ? map['data'] as String : null,
//       materialId:
//           map['materialId'] != null ? map['materialId'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MaterialComponent.fromJson(String source) =>
//       MaterialComponent.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'MaterialComponent(id: $id, type: $type, data: $data, materialId: $materialId)';
//   }

//   @override
//   bool operator ==(covariant MaterialComponent other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.type == type &&
//         other.data == data &&
//         other.materialId == materialId;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^ type.hashCode ^ data.hashCode ^ materialId.hashCode;
//   }
// }
