class User {
  String id;
  String email;
  String name;
  String? image;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.image,
  });

  toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "image": image,
    };
  }
}
