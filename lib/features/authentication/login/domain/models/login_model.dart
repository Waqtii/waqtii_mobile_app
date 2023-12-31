class LoginModel {
  String? token;
  String? message;
  Date? date;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }
}

class Date {
  String? username;
  String? email;

  Date.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
  }
}
