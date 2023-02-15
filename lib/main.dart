import 'package:flutter/material.dart';
import 'package:car_rating/Screens/Car_List.dart';
import 'package:car_rating/Screens/Car_info.dart';
import 'package:provider/provider.dart';
import 'Provider/car_provider.dart';
import 'package:car_rating/Screens/Open.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cars()),
      ],
      child: MaterialApp(
        title: 'Car_Rating',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: const Open(),
        routes: {
          Car_List.routee: (ctx) => Car_List(),
          Car_Info.routee: (ctx) => Car_Info(),
          Open.routee: (ctx) => const Open(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Car_Info(),
    );
  }
}
