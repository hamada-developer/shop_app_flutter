class HomeModel {

  bool? status;
  DataObj? data;

  HomeModel.fromJson(Map<String, dynamic> model){
    this.status = model['status'];
    this.data = DataObj.fromJson(model['data']);
  }
}

class DataObj {

  List<BannersObj> banners = [];
  List<ProductsObj> products = [];
  String? ad;

  DataObj.fromJson(Map<String, dynamic> model){
    model['banners'].forEach((element) {
      banners.add(BannersObj.fromJson(element));
    });
    model['products'].forEach((element) {
      products.add(ProductsObj.fromJson(element));
    });
    this.ad = model['ad'];
  }
}

class BannersObj {

  int? id;
  String? image;
  CategoryObj? category;

  BannersObj.fromJson(Map<String, dynamic> model){
    this.id = model['id'];
    this.image = model['image'];
  }
}

class CategoryObj {
  int? id;
  String? image;
  String? name;
}

class ProductsObj {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  bool? inFavorite;
  bool? inCart;

  ProductsObj.fromJson(Map<String, dynamic> model){
    this.id = model['id'];
    this.price = model['price'];
    this.oldPrice = model['old_price'];
    this.discount = model['discount'];
    this.image = model['image'];
    this.name = model['name'];
    this.description = model['description'];
    this.inFavorite = model['in_favorites'];
    this.inCart = model['in_cart'];
    model['images'].forEach((element){
      this.images.add(element);
    });
  }
}