import 'package:flutter/material.dart';

import 'package:custom_designs/src/pages/headers_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diseños app',
        home: HeadersPage());
  }
}