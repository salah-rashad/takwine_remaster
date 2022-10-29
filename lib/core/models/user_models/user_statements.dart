// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserStatements {
  final int? completed;
  final int? inProgress;
  final String? rate;

  const UserStatements({
    this.completed,
    this.inProgress,
    this.rate,
  });

  UserStatements copyWith({
    int? completed,
    int? inProgress,
    String? rate,
  }) {
    return UserStatements(
      completed: completed ?? this.completed,
      inProgress: inProgress ?? this.inProgress,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'completed': completed,
      'inProgress': inProgress,
      'rate': rate,
    };
  }

  factory UserStatements.fromMap(Map<String, dynamic> map) {
    return UserStatements(
      completed: map['completed'] != null ? map['completed'] as int : null,
      inProgress: map['inProgress'] != null ? map['inProgress'] as int : null,
      rate: map['rate'] != null ? map['rate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStatements.fromJson(String source) =>
      UserStatements.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserStatements(completed: $completed, inProgress: $inProgress, rate: $rate)';

  @override
  bool operator ==(covariant UserStatements other) {
    if (identical(this, other)) return true;

    return other.completed == completed &&
        other.inProgress == inProgress &&
        other.rate == rate;
  }

  @override
  int get hashCode => completed.hashCode ^ inProgress.hashCode ^ rate.hashCode;
}
