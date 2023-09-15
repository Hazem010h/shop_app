import 'package:shop_app/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  LoginModel loginModel;

  LoginSuccessState({required this.loginModel});
}
class LoginLoadingState extends LoginStates{}
class LoginErrorState extends LoginStates{}
class LoginChangePasswordVisability extends LoginStates{}