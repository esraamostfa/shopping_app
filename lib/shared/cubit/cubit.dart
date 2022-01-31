//import 'dart:html';

//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/models/change_favourites_model.dart';
import 'package:shopping_app/models/favorites_model.dart';
import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/models/search_model.dart';
import 'package:shopping_app/modules/categories/categories_screen.dart';
import 'package:shopping_app/modules/favorites/favorites_screen.dart';
import 'package:shopping_app/modules/products/products_screen.dart';
import 'package:shopping_app/modules/settings/settings_screen.dart';
import 'package:shopping_app/shared/components/constants.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/networks/local/cache_helper.dart';
import 'package:shopping_app/shared/networks/remote/dio_helper.dart';
import 'package:shopping_app/shared/networks/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  //Login

  static late LoginModel loginModel;

  void userLogin(String email, String password) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.message);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool isPassShown = false;

  void changePasswordVisibility() {
    isPassShown = !isPassShown;
    emit(ShopPassVisibilityState());
  }

  //HomeLayout
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNaveBarIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favourites = {};

  void getShopData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel!.data.banners[0].image);
      homeModel!.data.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
      });
      print(favourites);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data.data[0].name);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavouritesModel changeFavouritesModel;

  void changeFavoriteState(int productId) {

      favourites[productId] = !(favourites[productId]!);
      emit(ShopChangeFavoriteState());

      DioHelper.postData(
          url: FAVORITES, data: {'product_id': productId}, token: token)
          .then((value) {
        changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
        if(!changeFavouritesModel.status) {
          favourites[productId] = !(favourites[productId]!);
        } else {
          getFavourites();
        }
          print(changeFavouritesModel.message);
          emit(ShopSuccessChangeFavoriteState(changeFavouritesModel));
        }
      ).catchError((error) {
        emit(ShopErrorChangeFavoriteState());
        favourites[productId] = !(favourites[productId]!);
      });
    }

    FavoritesModel? favoritesModel;
    
    void getFavourites() {
      emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.data.toString());
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoriteState());
    });
  }

  LoginModel? profileModel;

    void getProfileData() {
      emit(ShopLoadingGetProfileDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ShopSuccessGetProfileDataState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileDataState());
    });
  }

  void updateProfileData(
      String name,
      String email,
      String phone,
      ) {
    emit(ShopLoadingUpdateProfileDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
      data: {
          'name': name,
        'email': email,
        'phone': phone
      }
    ).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ShopSuccessUpdateProfileDataState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileDataState());
    });
  }

  SearchModel? searchResultsModel;

  void getSearchResults(String searchText) {
    emit(ShopLoadingGetSearchResultsState());
    DioHelper.postData(url: SEARCH,
        data: {
      'text' : searchText
    },
    token: token
    ).then((value) {
      searchResultsModel = SearchModel.fromJson(value.data);
      print(searchResultsModel!.data.toString());
      emit(ShopSuccessGetSearchResultsState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetSearchResultsState());
    });
  }


  }
