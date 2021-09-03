
class User {
  User({
     this.id,
     this.email,
     this.name,
     this.lastname,
     this.phone,
    this.image,
     this.password,
    this.isAvailable,
    this.sessionToken,
  });


  String id;
  String email;
  String name;
  String lastname;
  String phone;
  dynamic image;
  String password;
  dynamic isAvailable;
  dynamic sessionToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        isAvailable: json["is_available"],
        sessionToken: json["session_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "is_available": isAvailable,
        "session_token": sessionToken,
      };
}
