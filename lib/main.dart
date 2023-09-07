import 'package:flutter/material.dart';
import 'package:gymapp/Providers/DataProvider.dart';
import 'package:gymapp/Providers/LocationProvider.dart';
import 'package:gymapp/router/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final query = prefs.getString('query');

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProxyProvider<LocationProvider, DataProvider>(
          update: (context, locationProvider, previousMessages) => DataProvider(locationProvider,query),
          create: (BuildContext context) => DataProvider(null,query),
        ),
        // ChangeNotifierProvider(create: (context) => DataProvider()),

      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const  Color(0xffb3020a),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) => CustomRouter.generateRoutes(settings),
    );
  }
}

