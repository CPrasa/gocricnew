class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
  });

  tojson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Password": password,
    };
  }
}
