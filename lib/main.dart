import 'package:flutter/material.dart';
import 'package:real_app/login_screen.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner:false,

    routes: {
        '/' : (context) => const Login(),
      },
    )
  );

}

