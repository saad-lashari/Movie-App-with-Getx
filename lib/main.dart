import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/home_controller.dart';
import 'package:movie_app/controller/search_controller.dart';
import 'package:movie_app/data/locall_database.dart';
import 'package:movie_app/view/dashboard/dashboard_screen.dart';

void main() async {
  // Load environment variables before using the app
  await dotenv.load(fileName: '.env');
  await LocalDatabase.createDatabase();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DashbordScreen(),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(MovieSearchController());
  }
}
