import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savingapp/views/main_screen.dart';
import 'package:savingapp/views/splash_screen.dart';

import 'bloc/saving_bloc.dart';
import 'bloc/saving_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavingsBloc()..add(LoadSavingsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

