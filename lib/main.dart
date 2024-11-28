import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1/Providers/authProvider.dart';
import 'package:task1/Screens/home.dart';
import 'package:task1/Screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.token});
  String? token;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => AuthProvider()..loadUserData()),
            ],
            child: MaterialApp(
              home: token == null ? LoginPage() : const HomePage(),
            ));
      },
    );
  }
}
