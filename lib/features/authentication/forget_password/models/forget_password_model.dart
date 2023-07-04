class ForgetPasswordModel {
  late String status;

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}
