class Session {
  final String id;
  final String userId;
  final String token;

  Session({required this.id, required this.userId, required this.token});

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      userId: json['userId'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}
