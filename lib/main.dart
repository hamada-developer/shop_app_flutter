import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/compents/constent.dart';
import 'package:shop_app/shared/compents/theme.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'cubit/main_cubit.dart';
import 'cubit/main_states.dart';
import 'layout/layout_screen.dart';
import 'modul/boarding/boarding_screen.dart';
import 'modul/login/cubit/login_cubit.dart';
import 'modul/login/login_screen.dart';
import 'modul/register/register_cubit/register_cubit.dart';

main() async {
  bool? doneBoarding;
  Widget? widget;
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initialDio();
  await CashHelper.initialSharedPreferences().then((value) {
    doneBoarding = CashHelper.getData(key: 'doneBoarding');
    token = CashHelper.getData(key: 'token');
    print(token);
    if (doneBoarding != null) {
      if (token != null) {
        widget = HomeLayout();
        print('HomeLayout');
      } else {
        widget = LoginScreen();
        print('LoginScreen');
      }
    } else {
      widget = BoardingScreen();
      print('BoardingScreen');
    }
  });
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    doneBoarding: doneBoarding,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? doneBoarding;
  final Widget? widget;

  const MyApp({Key? key, this.doneBoarding, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: widget,
            theme: lightMode,
          );
        },
      ),
    );
  }
}
