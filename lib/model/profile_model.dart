class ProfileModel{

  bool? status;
  DataProfile? data;

  ProfileModel.fromJson(Map<String, dynamic> json){
    this.status = json['status'];
    this.data = DataProfile.fromJson(json['data']);
  }
}

class DataProfile{

  String? name;
  String? email;
  String? phone;

  DataProfile.fromJson(Map<String, dynamic> json){
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
  }
}