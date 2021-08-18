class CategoriesModel {

  bool? status;
  DataObj? data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    this.status = json['status'];
    this.data = DataObj.fromJson(json['data']);
  }
}
 class DataObj{

  List<DataObjList> data = [];

  DataObj.fromJson(Map<String, dynamic> model){
    model['data'].forEach((element){
      this.data.add(DataObjList.fromJson(element));
    });
  }
 }

 class DataObjList{
  int? id;
  String? name;
  String? image;

  DataObjList.fromJson(Map<String, dynamic> model){
    this.id = model['id'];
    this.name = model['name'];
    this.image = model['image'];
  }
 }