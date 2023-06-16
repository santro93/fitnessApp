class UserModel {
  String? id;
  String? name;
  String? mobile;
  String email;
  String password;

  UserModel(
      {this.id,
      this.name,
      this.mobile,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      mobile: map['mobile'],
      email: map['email'],
      password: map['password'],
    );
  }
}
