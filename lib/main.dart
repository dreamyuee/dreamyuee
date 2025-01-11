import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aerium/app_theme.dart';
import 'package:aerium/presentation/routes/routes.dart';
import 'package:aerium/values/values.dart';
// Ensure this is the correct path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.APP_TITLE,
      theme: AppTheme.lightThemeData,
      debugShowCheckedModeBanner: false,
      // home: AppInitializer(), // Start with AppInitializer
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}
// class AppInitializer extends StatefulWidget {
//   @override
//   _AppInitializerState createState() => _AppInitializerState();
// }

// class _AppInitializerState extends State<AppInitializer> {
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//   Future<void> _initializeApp() async {
//     // Simulate app initialization
//     await Future.delayed(Duration(seconds: 3));
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return GifLoaderWithDynamicText(); // Use the GIF loader widget
//     } else {
//       return HomePage(); // Replace with your actual HomePage
//     }
//   }
// }
