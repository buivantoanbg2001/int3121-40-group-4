class Auth {
  final String accessToken;

  const Auth({
    required this.accessToken,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      accessToken: json['accessToken'],
    );
  }
}
