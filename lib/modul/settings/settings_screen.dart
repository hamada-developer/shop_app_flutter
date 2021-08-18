import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modul/home/home_cubit/home_cubit.dart';
import 'package:shop_app/modul/home/home_cubit/home_states.dart';
import 'package:shop_app/modul/login/login_screen.dart';
import 'package:shop_app/shared/compents/compents.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getProfile != null,
          builder: (context) {
            nameController.text = cubit.getProfile!.data!.name.toString();
            emailController.text = cubit.getProfile!.data!.email.toString();
            phoneController.text = cubit.getProfile!.data!.phone.toString();
            if(state is PutDataUpdateProfileSuccess){
              if(state.updateProfile.status == true){
                nameController.text = cubit.updateProfile!.data!.name.toString();
                emailController.text = cubit.updateProfile!.data!.email.toString();
                phoneController.text = cubit.updateProfile!.data!.phone.toString();
              }
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DefaultTextFormField(
                        controller: nameController,
                        labelText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DefaultTextFormField(
                        controller: emailController,
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DefaultTextFormField(
                        controller: phoneController,
                        labelText: 'Phone',
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DefaultButton(
                          label: 'logout'.toUpperCase(),
                          onPressed: () {
                            CashHelper.removeFromSharedPreferences(key: 'token')
                                .then((value) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return LoginScreen();
                                }),
                                (route) => false,
                              );
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      DefaultButton(
                        label: "Update".toUpperCase(),
                        onPressed: (){
                          cubit.putDataUpdate(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
