part of "./auth.dart";

class AuthModel {
  int id;
  String email;
  String name;
  String staticToken;
  bool isActive;
  String clientId;
  String clientSecret;

  AuthModel({
    required this.id,
    required this.email,
    required this.name,
    required this.staticToken,
    required this.isActive,
    required this.clientId,
    required this.clientSecret,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        staticToken: json["static_token"],
        isActive: json["is_active"],
        clientId: json["client_id"],
        clientSecret: json["client_secret"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
        "static_token": staticToken,
        "is_active": isActive,
        "client_id": clientId,
        "client_secret": clientSecret,
      };

  String toStringJson() => json.encode(toMap());
}
