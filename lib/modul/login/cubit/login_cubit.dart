import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/shared/compents/constent.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? shopModel;

  IconData icon = Icons.remove_red_eye;
  bool obscure = true;

  void login({
    required String email,
    required String password,
  }) {
    emit(PostDataLoginLoading());
    DioHelper.post(
      method: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
      headers: {
        LANG : AR,
      },
    ).then((value) {
      shopModel = LoginModel.fromJson(value.data);
      emit(PostDataLoginSuccess(shopModel!));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(PostDataLoginError());
    });
  }

  void toggleObscure(){

    obscure = !obscure;
    if(obscure){
      icon = Icons.remove_red_eye;
    }
    else{
      icon = Icons.visibility_off;
    }
    emit(ObscureTextState());
  }


}
