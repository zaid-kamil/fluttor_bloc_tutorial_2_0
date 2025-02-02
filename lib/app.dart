import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttor_bloc_tutorial/features/home/presentation/pages/home.dart';

class ImageShareApp extends StatelessWidget {
  const ImageShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Share',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        // for the web
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.unknown,
        },
      ),
      home: HomePage(),
    );
  }
}
