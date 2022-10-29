// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// import 'material_attachment.dart';
// import 'material_component.dart';

// class MaterialContent {
//   int? id;
//   List<MaterialComponent>? components;
//   List<MaterialAttachment>? attachments;

//   MaterialContent({
//     this.id,
//     this.components,
//     this.attachments,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'components': components?.map((x) => x.toMap()).toList(),
//       'attachments': attachments?.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory MaterialContent.fromMap(Map<String, dynamic> map) {
//     return MaterialContent(
//       id: map['id'] != null ? map['id'] as int : null,
//       components: map['components'] != null
//           ? List<MaterialComponent>.from(
//               (map['components'] as List<int>).map<MaterialComponent?>(
//                 (x) => MaterialComponent.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       attachments: map['attachments'] != null
//           ? List<MaterialAttachment>.from(
//               (map['attachments'] as List<int>).map<MaterialAttachment?>(
//                 (x) => MaterialAttachment.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MaterialContent.fromJson(String source) =>
//       MaterialContent.fromMap(json.decode(source) as Map<String, dynamic>);

//   MaterialContent copyWith({
//     int? id,
//     List<MaterialComponent>? components,
//     List<MaterialAttachment>? attachments,
//   }) {
//     return MaterialContent(
//       id: id ?? this.id,
//       components: components ?? this.components,
//       attachments: attachments ?? this.attachments,
//     );
//   }

//   @override
//   String toString() =>
//       'MaterialContent(id: $id, components: $components, attachments: $attachments)';

//   @override
//   bool operator ==(covariant MaterialContent other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         listEquals(other.components, components) &&
//         listEquals(other.attachments, attachments);
//   }

//   @override
//   int get hashCode => id.hashCode ^ components.hashCode ^ attachments.hashCode;
// }
