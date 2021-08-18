
import 'package:shop_app/model/login_model.dart';

abstract class LoginStates{}

class InitialLoginState extends LoginStates{}

class PostDataLoginSuccess extends LoginStates{

  final LoginModel shopModel;

  PostDataLoginSuccess(this.shopModel);
}
class PostDataLoginError extends LoginStates{}
class PostDataLoginLoading extends LoginStates{}

class ObscureTextState extends LoginStates{}