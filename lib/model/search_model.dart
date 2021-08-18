class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  List<DataItem> data = [];

  SearchData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataItem.fromJson(element));
    });
  }
}

class DataItem {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorite;
  bool? inCart;

  DataItem.fromJson(Map<String, dynamic> model) {
    this.id = model['id'];
    this.price = model['price'];
    this.oldPrice = model['old_price'];
    this.discount = model['discount'];
    this.image = model['image'];
    this.name = model['name'];
    this.description = model['description'];
    this.inFavorite = model['in_favorites'];
    this.inCart = model['in_cart'];
  }
}
