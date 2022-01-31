import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/search_model.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    ShopLoginCubit cubit = ShopLoginCubit.get(context);

    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {

        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
              padding: const EdgeInsets.all(19.0),
              child: defaultTextForm(
                  controller: searchController,
                  textInputType: TextInputType.text,
                  onChange: (value) {
                    cubit.getSearchResults(value);
                  },
                  label: 'search',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'search can\'t be null';
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: Icons.search),
            ),
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit.searchResultsModel != null,
                  builder: (context) => ListView.separated(
                      itemBuilder: (context, index) => buildProductListItem(cubit.searchResultsModel!.data!.searchProducts[index], context),
                      separatorBuilder: (context, index) => buildItemsDivider(),
                      itemCount: cubit.searchResultsModel!.data!.searchProducts.length),
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget buildProductListItem(SearchProducts model, context) => Container(
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
