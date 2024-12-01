import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootcamp_app/pages/splash_page.dart';
import 'package:bootcamp_app/providers/space_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpaceProvider(),
      child: const MaterialApp(
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
