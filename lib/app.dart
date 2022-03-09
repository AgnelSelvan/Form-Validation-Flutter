import 'package:flutter/material.dart';
import 'package:registration/res/colors.dart';
import 'package:registration/views/pages/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: AppColors.primarySwatch,
        textTheme: TextTheme(
          headline3: const TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
          labelMedium:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]!),
          subtitle2: TextStyle(
            color: Colors.grey[500],
            letterSpacing: 0.5,
            fontSize: 14,
          ),
        ),
      ),
      home: const RegisterScreen(),
    );
  }
}
