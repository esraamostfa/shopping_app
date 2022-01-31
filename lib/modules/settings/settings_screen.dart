import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopLoginCubit.get(context);
        nameController.text = cubit.profileModel!.data!.name;
        emailController.text = cubit.profileModel!.data!.email;
        phoneController.text = cubit.profileModel!.data!.phone;
        return ConditionalBuilder(
        condition: cubit.profileModel != null,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(19.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is ShopLoadingUpdateProfileDataState)
                LinearProgressIndicator(),
                SizedBox(height: 19,),
                defaultTextForm(controller: nameController,
                    textInputType: TextInputType.name,
                    label: 'Name',
                    validator: (String value) {
                  if(value.isEmpty) {
                    return 'name must not be empty';
                  }
                  return null;
                    },
                    prefixIcon: Icons.person
                ),
                SizedBox(height: 19,),

                defaultTextForm(controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    label: 'Email Address',
                    validator: (String value) {
                      if(value.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    prefixIcon: Icons.email
                ),
                SizedBox(height: 19,),

                defaultTextForm(controller: phoneController,
                    textInputType: TextInputType.phone,
                    label: 'Phone',
                    validator: (String value) {
                      if(value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    prefixIcon: Icons.phone_android
                ),

                SizedBox(height: 19,),

                defaultButton(text: 'logout',
                    isUpperCase: true,
                    function: (){
                  signOut(context);
                    }),

                SizedBox(height: 19,),

                defaultButton(text: 'update',
                    isUpperCase: true,
                    function: (){
                  if(formKey.currentState!.validate()) {
                    cubit.updateProfileData(nameController.text, emailController.text, phoneController.text);
                  }
                    }),
              ],
            ),
          ),
        ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
      );
  }
    );
  }
}
