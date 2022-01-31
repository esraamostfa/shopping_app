class FavoritesModel {
  late bool status;
  late Data? data;


  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  late int currentPage;
  late List<FavoritesData> favoritesData = [];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late Null nextPageUrl;
  late String path;
  late int perPage;
  late Null prevPageUrl;
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        favoritesData.add(FavoritesData.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  late int id;
  late FavoritesProduct? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new FavoritesProduct.fromJson(json['product']) : null;
  }
}

class FavoritesProduct {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  FavoritesProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}