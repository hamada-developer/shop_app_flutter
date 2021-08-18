

import 'package:shop_app/model/register_model.dart';

abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class PostDataRegisterSuccess extends RegisterStates {
  final RegisterModel registerModel;

  PostDataRegisterSuccess(this.registerModel);
}

class PostDataRegisterError extends RegisterStates {}

class PostDataRegisterLoading extends RegisterStates {}

class ObscureTextStateRegister extends RegisterStates {}
