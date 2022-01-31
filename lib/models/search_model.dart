class SearchModel {
  late bool status;
  late String? message;
  late Data? data;


  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  late int currentPage;
  late List<SearchProducts> searchProducts = [];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late String? nextPageUrl;
  late String path;
  late int perPage;
  late String? prevPageUrl;
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        searchProducts.add(SearchProducts.fromJson(element));
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

  class SearchProducts {
  late int id;
  late dynamic price;
  late bool inFavorites;
  late bool inCart;
  late String image;
  late String name;
  late String description;

  SearchProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}