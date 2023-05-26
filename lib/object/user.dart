class User {
  final String email;
  final int uid;
  final String username;

  const User({
    required this.username,
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };
}
