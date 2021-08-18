import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modul/register/register_screen.dart';
import 'package:shop_app/shared/compents/compents.dart';
import 'package:shop_app/shared/compents/constent.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is PostDataLoginSuccess){
          if(state.shopModel.data != null){
            CashHelper.saveData(key: 'token', value: state.shopModel.data!.token.toString());
            navigateToAndFinish(
              context: context,
              widget: HomeLayout(),
            );
            token = state.shopModel.data!.token.toString();
          }
          else{
            showToastComponent(msg: state.shopModel.message.toString());
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login'.toUpperCase(),
                        style:
                            Theme.of(context).textTheme.headline5!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DefaultTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must be not email is empty';
                          }
                        },
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                        onEditingComplete: () {
                          if (formKey.currentState!.validate()) {
                            cubit.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        obscureText: cubit.obscure,
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
                          onPressed: () {
                            cubit.toggleObscure();
                          },
                          icon: Icon(
                            cubit.icon,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! PostDataLoginLoading,
                        builder: (context) => DefaultButton(
                          label: 'Login',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'don\'t have an account?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Register now',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widget: RegisterScreen(),
                              );
                            },
                          ),
                        ],
                      ),
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
