// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? birthDate;
  String? image;
  String? phoneNumber;
  String? city;
  String? job;
  
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.birthDate,
    this.image,
    this.phoneNumber,
    this.city,
    this.job,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? birthDate,
    String? image,
    String? phoneNumber,
    String? city,
    String? job,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      job: job ?? this.job,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'image': image,
      'phoneNumber': phoneNumber,
      'city': city,
      'job': job,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
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
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, birthDate: $birthDate, image: $image, phoneNumber: $phoneNumber, city: $city, job: $job)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.image == image &&
        other.phoneNumber == phoneNumber &&
        other.city == city &&
        other.job == job;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        image.hashCode ^
        phoneNumber.hashCode ^
        city.hashCode ^
        job.hashCode;
  }
}
