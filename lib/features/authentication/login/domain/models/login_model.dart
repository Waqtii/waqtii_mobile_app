class LoginModel {
  late String token;
  late String message;
  Date? date;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    date = json['date'] != null ? Date.fromJson(json['data']) : null;
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
