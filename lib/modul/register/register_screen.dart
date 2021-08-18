import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modul/register/register_cubit/register_cubit.dart';
import 'package:shop_app/modul/register/register_cubit/register_states.dart';
import 'package:shop_app/shared/compents/compents.dart';
import 'package:shop_app/shared/compents/constent.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is PostDataRegisterSuccess) {
          if (state.registerModel.data != null) {
            CashHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token.toString());
            token = state.registerModel.data!.token.toString();
            navigateToAndFinish(
              context: context,
              widget: HomeLayout(),
            );
          } else {
            showToastComponent(msg: state.registerModel.message.toString());
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email Address',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must be not password is empty';
                        }
                      },
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      keyboardType: TextInputType.phone,
                      onEditingComplete: () {
                        if (formKey.currentState!.validate()) {
                          cubit.register(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      labelText: 'Phone',
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! PostDataRegisterLoading,
                      builder: (context) {
                        return DefaultButton(
                          label: 'Register'.toUpperCase(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.register(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        );
                      },
                      fallback: (context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
