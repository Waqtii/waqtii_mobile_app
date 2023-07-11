class TasksModel {
  int? id;
  String? title;
  String? status;
  String? priority;
  String? description;
  String? notes;
  String? audioFile;
  String? date;
  String? createdAt;
  int? user;

  TasksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    priority = json['priority'];
    description = json['description'];
    notes = json['notes'];
    audioFile = json['audio_file'];
    date = json['date'];
    createdAt = json['created_at'];
    user = json['user'];
  }
}
