import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/dio_helper.dart';
import 'package:shop_app/end_points.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/models/login_model.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(LoginInitialState());

  LoginModel? loginModel;

  bool obsecurePassword=true;
  IconData suffixPasswordIcon=Icons.visibility_rounded;

  static LoginCubit get(context)=>BlocProvider.of(context);

  void changePasswordVisability(){
    obsecurePassword= !obsecurePassword;
    suffixPasswordIcon= obsecurePassword? Icons.visibility_rounded: Icons.visibility_off_rounded;
    emit(LoginChangePasswordVisability());
  }

  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: loginEndPoint,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel: loginModel!));
    }).catchError((e){
      print(e.toString());
      emit(LoginErrorState());
    });
  }
}