class RegisterUserModel {
  String? message;
  Data? data;

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? username;
  String? email;
  String? name;
  String? mobile;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    name = json['name'];
    mobile = json['mobile'];
  }
}
