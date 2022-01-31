
import 'package:shopping_app/models/change_favourites_model.dart';
import 'package:shopping_app/models/login_model.dart';

abstract class ShopLoginStates {}

//Login

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates  {}
class ShopLoginSuccessState extends ShopLoginStates  {
  final LoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShopLoginStates  {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopPassVisibilityState extends ShopLoginStates  {}


//HomeLayout

class ChangeBottomNavState extends ShopLoginStates {}

class ShopLoadingHomeDataState extends ShopLoginStates {}
class ShopSuccessHomeDataState extends ShopLoginStates {}
class ShopErrorHomeDataState extends ShopLoginStates {}

class ShopSuccessCategoriesState extends ShopLoginStates {}
class ShopErrorCategoriesState extends ShopLoginStates {}

class ShopChangeFavoriteState extends ShopLoginStates {}

class ShopSuccessChangeFavoriteState extends ShopLoginStates {
  final ChangeFavouritesModel changeFavouritesModel;
  ShopSuccessChangeFavoriteState(this.changeFavouritesModel);
}
class ShopErrorChangeFavoriteState extends ShopLoginStates {}

class ShopLoadingGetFavoriteState extends ShopLoginStates {}
class ShopSuccessGetFavoriteState extends ShopLoginStates {}
class ShopErrorGetFavoriteState extends ShopLoginStates {}

class ShopLoadingGetProfileDataState extends ShopLoginStates {}
class ShopSuccessGetProfileDataState extends ShopLoginStates {
  final LoginModel profileModel;
  ShopSuccessGetProfileDataState(this.profileModel);
}
class ShopErrorGetProfileDataState extends ShopLoginStates {}


class ShopLoadingUpdateProfileDataState extends ShopLoginStates {}
class ShopSuccessUpdateProfileDataState extends ShopLoginStates {
  final LoginModel profileModel;
  ShopSuccessUpdateProfileDataState(this.profileModel);
}
class ShopErrorUpdateProfileDataState extends ShopLoginStates {}

class ShopLoadingGetSearchResultsState extends ShopLoginStates {}
class ShopSuccessGetSearchResultsState extends ShopLoginStates {}
class ShopErrorGetSearchResultsState extends ShopLoginStates {}