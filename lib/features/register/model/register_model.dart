class RegisterRequestModel {
  final String email;
  final String password;
  final String name;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        email: json["email"],
        password: json["password"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "name": name,
  };
}
