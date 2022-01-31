import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/models/favorites_model.dart';
import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    //List<FavoritesData> favorites = ShopLoginCubit.get(context).favoritesModel!.data!.favoritesData!;
    ShopLoginCubit cubit = ShopLoginCubit.get(context);
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {

      },
        builder: (context, state) => ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoriteState,
            builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavoritesItem(cubit.favoritesModel!.data!.favoritesData[index].product!, context),
            separatorBuilder: (context, index) => buildItemsDivider(),
            itemCount: cubit.favoritesModel!.data!.favoritesData.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
        );
  }

  Widget buildFavoritesItem(FavoritesProduct model, context) => Container(
    height: 121,
    padding: EdgeInsets.all(19),
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 121,
              height: 121,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 21,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: defaultColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopLoginCubit.get(context).changeFavoriteState(model.id);
                      print('favourite pressed');
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopLoginCubit.get(context).favourites[model.id]! ? defaultColor : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white
                        ,
                        size: 15,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
