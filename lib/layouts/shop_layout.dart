import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/login/login_screen.dart';
import 'package:shopping_app/modules/search/search_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/networks/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var cubit = ShopLoginCubit.get(context);

    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                  onPressed: () {
                naveTo(context, SearchScreen());
              },
                  icon: Icon(Icons.search)
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNaveBarIndex(index);
            },

          ) ,
        );
      },

    );
  }
}
