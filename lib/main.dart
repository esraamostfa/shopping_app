import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layouts/shop_layout.dart';
import 'package:shopping_app/modules/login/login_screen.dart';
import 'package:shopping_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopping_app/shared/components/constants.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/cubit_observer.dart';
import 'package:shopping_app/shared/cubit/shop_register_cubit.dart';
import 'package:shopping_app/shared/networks/local/cache_helper.dart';
import 'package:shopping_app/shared/networks/remote/dio_helper.dart';
import 'package:shopping_app/shared/styles/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData('onBoarding');
  token = CacheHelper.getData('token');

  Widget widget;

  if(onBoarding != null) {
    if (token != null) widget = ShopLayout();
    else widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }


  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
        BlocProvider(
        create: (context) => ShopLoginCubit()..getShopData()..getCategories()..getFavourites()..getProfileData(),),
      BlocProvider(create: (context) => ShopRegisterCubit())
    ],
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    ),);

  }
}
