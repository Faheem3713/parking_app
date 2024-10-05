class UserModel {
  final String? email, password, id;

  String? get name => email?.split('@')[0];

  UserModel({this.email, this.password, this.id});

  UserModel copyWith({
    String? email,
    String? password,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }
}
