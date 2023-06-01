class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final String name;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.name,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
