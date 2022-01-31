//import 'dart:html';

//import 'dart:html';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layouts/shop_layout.dart';
import 'package:shopping_app/modules/login/login_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/components/constants.dart';
import 'package:shopping_app/shared/cubit/shop_register_cubit.dart';
import 'package:shopping_app/shared/cubit/shop_register_states.dart';
import 'package:shopping_app/shared/networks/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status) {
            print(state.registerModel.message);
            print(state.registerModel.data!.token);
            showToast(state.registerModel.message, ToastStates.SUCCESS);

            CacheHelper.saveData(
                    key: 'token', value: state.registerModel.data!.token)
                .then((value) {
              token = state.registerModel.data!.token;
              navigateAndFinish(context, ShopLayout());
            });
          } else {
            print(state.registerModel.message);
            showToast(state.registerModel.message, ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopRegisterCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(21.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'Register now to brows our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 29,
                      ),
                      defaultTextForm(
                          controller: nameController,
                          textInputType: TextInputType.name,
                          label: 'Name',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.person),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          label: 'Email Address',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          label: 'Phone',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.phone_android),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          label: 'Password',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: cubit.isPassShown
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onSuffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          isPassword: !cubit.isPassShown,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                  passwordController.text);
                            }
                          }),
                      SizedBox(
                        height: 29,
                      ),
                      ConditionalBuilder(
                        condition: state != ShopRegisterLoadingState(),
                        builder: (context) => defaultButton(
                            text: 'register',
                            isUpperCase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    phoneController.text);
                              }
                            }),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('already have an account?'),
                          TextButton(
                            onPressed: () {
                              navigateAndFinish(context, LoginScreen());
                            },
                            child: Text('login'.toUpperCase()),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
