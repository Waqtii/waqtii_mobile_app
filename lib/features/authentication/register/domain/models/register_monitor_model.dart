class MonitorData {
  late String fullName;
  late String email;
  late String password;
  late String userName;
  late String phoneNumber;
  late String? gender;
  late String? linkedin;
  late String? github;

  MonitorData.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    linkedin = json['linkedin'];
    github = json['github'];
  }
}
