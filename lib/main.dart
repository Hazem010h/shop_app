import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache_helper.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/app_states.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_states.dart';
import 'package:shop_app/dio_helper.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/onboarding_screen.dart';

import 'cubit/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();
  Widget startingScreen;
  bool showBoardingScreen=CacheHelper.getData(key: 'showBoardingScreen') ?? true;
  token=CacheHelper.getData(key: 'token') ?? '';
  print(token);
  if(showBoardingScreen){
    startingScreen=OnBoardingScreen();
  }else{
    if(token == ''){
      startingScreen=LoginScreen();
    }else{
      startingScreen=LayoutScreen();
    }
  }
  runApp(MyApp(startingScreen:startingScreen ,));
}

class MyApp extends StatelessWidget {
  Widget startingScreen;

  MyApp({required this.startingScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData(),),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            home: startingScreen,
            theme: lightTheme,
          );
        },
      ),
    );
  }
}



