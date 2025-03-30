class UserModel {
  String? username;
  String? password;
  String? name;

  UserModel({this.username, this.password, this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    return data;
  }
}
