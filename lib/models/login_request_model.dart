class LoginRequestModel {
  String? username;
  String? password;
  String? isAdmin;

  LoginRequestModel({this.username, this.password, this.isAdmin});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data['is_admin'] = isAdmin;
    return data;
  }
}