class Review {
  final String id;
  final String title;
  final int ratings;
  final User user;
  final String createdAt;

  Review(
      {required this.createdAt,
      required this.id,
      required this.title,
      required this.ratings,
      required this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      createdAt: json['createdAt'],
      id: json['_id'],
      title: json['title'],
      ratings: json['ratings'],
      user: User.fromJson(json['user']),
    );
  }
}
class User {
  final String id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  // Factory constructor to create a User from a Map (JSON).
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
    );
  }

  // Method to convert the User object to a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

