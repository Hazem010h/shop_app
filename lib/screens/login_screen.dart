import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache_helper.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/cubit/login_cubit.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/reusable_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contexxt)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token);
              navigateAndFinish(context: context, screen: LayoutScreen());
            }else{
              print(state.loginModel.status);
              print(state.loginModel.message);
            }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        reusableTextFormField(
                          label: 'Email',
                          onTap: (){},
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter an email';
                            }
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          activeColor: defaultLightColor,
                          prefix: Icon(
                              Icons.email_rounded
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        reusableTextFormField(
                          label: 'password',
                          onTap: (){},
                          onSubmit: (String? value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter password';
                            }
                          },
                          controller: passwordController,
                          obscure: LoginCubit.get(context).obsecurePassword,
                          keyboardType: TextInputType.visiblePassword,
                          activeColor: defaultLightColor,
                          prefix: Icon(
                            Icons.key_rounded,
                          ),
                          suffix: IconButton(
                              onPressed: (){
                                LoginCubit.get(context).changePasswordVisability();
                              },
                            icon: Icon(LoginCubit.get(context).suffixPasswordIcon),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          child: Row(
                            children: [
                              Text('Don\'t have am account ? '),
                              TextButton(onPressed: (){}, child: Text('Register Now')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,),
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context)=>reusableElevatedButton(
                              label: 'Login',
                              backColor: defaultLightColor,
                              function: (){
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context)=>CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );
        },
      ),
    );
  }
}
