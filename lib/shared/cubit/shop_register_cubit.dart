import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/components/constants.dart';
import 'package:shopping_app/shared/cubit/shop_register_states.dart';
import 'package:shopping_app/shared/networks/local/cache_helper.dart';
import 'package:shopping_app/shared/networks/remote/dio_helper.dart';
import 'package:shopping_app/shared/networks/remote/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  static late LoginModel registerModel;

  void userRegister(String name, String email, String password, String phone) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    })
        .then((value) {
      registerModel = LoginModel.fromJson(value.data);
      print(registerModel.message);
      emit(ShopRegisterSuccessState(registerModel));

    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool isPassShown = false;

  void changePasswordVisibility() {
    isPassShown = !isPassShown;
    emit(ShopPassVisibilityState());
  }

}