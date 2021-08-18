class GetFavorite {
  bool? status;
  Data? data;

  GetFavorite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<DataProduct> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataProduct.fromJson(element));
    });
  }
}

class DataProduct {
  Product? product;

  DataProduct.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
