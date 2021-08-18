import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/register_model.dart';
import 'package:shop_app/modul/register/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;

  IconData icon = Icons.remove_red_eye;
  bool obscure = true;

  void toggleObscure() {
    obscure = !obscure;
    if (obscure) {
      icon = Icons.remove_red_eye;
    } else {
      icon = Icons.visibility_off;
    }
    emit(ObscureTextStateRegister());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(PostDataRegisterLoading());
    DioHelper.post(
      method: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    )
    .then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      if(registerModel != null)
      emit(PostDataRegisterSuccess(registerModel!));
      else throw 'registerModel is null';
    })
    .catchError((onError){
      print('Error: ${onError.toString()}');
      emit(PostDataRegisterError());
    });
  }
}
