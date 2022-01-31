import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DataModel> categories =
        ShopLoginCubit.get(context).categoriesModel!.data.data;

    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(categories[index]),
              separatorBuilder: (context, index) => buildItemsDivider(),
              itemCount: categories.length
          );
        },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(19.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 85,
              height: 85,
            ),
            SizedBox(
              width: 21,
            ),
            Text(
              '${model.name}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
