class User {
  final String id;
  final String email;
  final String name;

  User({required this.id, required this.email, required this.name});

  factory User.fromMap(Map<String, dynamic> userMap) {
    return User(
      id: userMap['id'],
      email: userMap['email'],
      name: userMap['first_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'first_name': name, 'email': email};
  }
}
