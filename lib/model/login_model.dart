class LoginModel{

  bool? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String , dynamic> model){
    this.status = model['status'];
    this.message = model['message'];
    this.data = model['data'] != null? UserData.fromJson(model['data']): null;
  }
}
class UserData{

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

  UserData.fromJson(Map<String , dynamic> model){
    this.id = model['id'];
    this.name = model['name'];
    this.email = model['email'];
    this.phone = model['phone'];
    this.token = model['token'];
    this.points = model['points'];
    this.credit = model['credit'];
  }
}