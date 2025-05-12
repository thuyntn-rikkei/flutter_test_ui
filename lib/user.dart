class User {
  final String? username;
  final String? fullname;
  final String? email;
  final int? age;
  final bool? isGirl;
  final String? job;
  final String? imageUrl;

  User({
    this.username,
    this.fullname,
    this.email,
    this.age,
    this.isGirl,
    this.job,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      age: json['age'],
      isGirl: json['isGirl'],
      job: json['job'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'User{username: $username, fullname: $fullname, email: $email, age: $age, isGirl: $isGirl, job: $job, imageUrl: $imageUrl}';
  }
}
