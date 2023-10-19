import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/resources/route_manager.dart';
import '../presentation/resources/theme_manager.dart';
import '../domain/mode_data_provider.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  static final MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ModeDataProvider(),
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}