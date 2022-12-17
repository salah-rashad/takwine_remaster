// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import '../../helpers/constants/urls.dart';

class User {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? gender;
  String? birthDate;
  String? imageUrl;
  String? phoneNumber;
  String? city;
  String? job;

  User({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.gender,
    this.birthDate,
    this.imageUrl,
    this.phoneNumber,
    this.city,
    this.job,
  }) {
    if (imageUrl != null) {
      bool validURL = Uri.parse(imageUrl!).isAbsolute;

      if (!validURL) {
        imageUrl = Url.HOST_URI.replace(path: imageUrl!).toString();
      }
    }
  }

  User copyWith({
    int? id,
    String? first_name,
    String? last_name,
    String? email,
    String? gender,
    String? birthDate,
    String? imageUrl,
    String? phoneNumber,
    String? city,
    String? job,
  }) {
    return User(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      job: job ?? this.job,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'city': city,
      'job': job,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      job: map['job'] != null ? map['job'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, first_name: $first_name, last_name: $last_name, email: $email, gender: $gender, birthDate: $birthDate, imageUrl: $imageUrl, phoneNumber: $phoneNumber, city: $city, job: $job)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.email == email &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        other.city == city &&
        other.job == job;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        city.hashCode ^
        job.hashCode;
  }
}
