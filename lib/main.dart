import 'package:flutter/material.dart';
import 'package:temp/page_10.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {'/': (context) => EmployeeStatisticsScreen()},
    );
  }
}
