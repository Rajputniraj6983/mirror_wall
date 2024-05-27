import 'package:flutter/material.dart';
import 'package:mirror_wall/view/screen/Homepage.dart';

void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleScreen(url: "",),
    );
  }
}
