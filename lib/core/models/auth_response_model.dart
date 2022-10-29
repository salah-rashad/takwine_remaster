// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class AuthResponse {
//   bool? error;
//   dynamic data;

//   AuthResponse({
//     this.error,
//     this.data,
//   });

//   AuthResponse copyWith({
//     bool? error,
//     dynamic data,
//   }) {
//     return AuthResponse(
//       error: error ?? this.error,
//       data: data ?? this.data,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'error': error,
//       'data': data,
//     };
//   }

//   factory AuthResponse.fromMap(Map<String, dynamic> map) {
//     return AuthResponse(
//       error: map['error'] != null ? map['error'] as bool : null,
//       data: map['data'] as dynamic,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AuthResponse.fromJson(String source) =>
//       AuthResponse.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'AuthResponse(error: $error, data: $data)';

//   @override
//   bool operator ==(covariant AuthResponse other) {
//     if (identical(this, other)) return true;

//     return other.error == error && other.data == data;
//   }

//   @override
//   int get hashCode => error.hashCode ^ data.hashCode;
// }
