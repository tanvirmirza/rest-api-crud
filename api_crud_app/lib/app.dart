import 'package:api_crud_app/Style/style.dart';
import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CRUD API PROJECT",
        theme: ThemeData(
          primaryColor: appPrimaryBackground,
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: bodyBackground,
              elevation: 0,
              foregroundColor: colorGrey,
              titleSpacing: 5,
              titleTextStyle: TextStyle(
                  color: colorGrey, fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        home: const Scaffold(
          body: SplashScreen(),
        ));
  }
}



