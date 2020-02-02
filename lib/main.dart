import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_state.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
      ],
      child: MaterialApp(
        title: "Alphabêtes",
        debugShowCheckedModeBanner: false,
        home: HomePage(
          title: 'Alphabêtes',
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
