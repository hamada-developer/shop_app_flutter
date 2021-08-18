class UpdateProfile {
  bool? status;
  String? message;
  DataUpdate? data;

  UpdateProfile.formJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.message = json['message'];
    this.data = json['data'] != null?  DataUpdate.fromJson(json['data']): null;
  }
}

class DataUpdate {
  String? name;
  String? email;
  String? phone;
  String? token;

  DataUpdate.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.token = json['token'];
  }
}
