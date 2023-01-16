enum UserGender {
  m("ذكر"),
  f("أنثى");

  final String friendlyName;
  const UserGender(this.friendlyName);

  static UserGender? from(String? s) {
    var values = UserGender.values.map((e) => e.name).toList();
    if (values.contains(s)) {
      return UserGender.values.firstWhere((element) => element.name == s);
    }
    return null;
  }
}
