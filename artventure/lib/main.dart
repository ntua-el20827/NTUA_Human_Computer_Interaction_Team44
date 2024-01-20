import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:artventure/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final dbHelper = DatabaseHelper();
  //final database = await dbHelper.initDB();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArtVenture Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 91, 64, 138)),
        useMaterial3: true,
      ),
      // Use AppRoutes.landing as the home property
      //home: AppRoutes.defineRoutes()[AppRoutes.landing]!(context),
      initialRoute: AppRoutes.landing,
      routes: AppRoutes.defineRoutes(),
    );
  }
}
