import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/loginScreen.dart';

import './provider/weatherProvider.dart';
import 'screens/homeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDtMW8hvGSNzFIyD5sPVVWAgIn6rX7Byhc",
      appId: "1:737278257484:android:3801d2eb43111bf54607e9",
      messagingSenderId: "Messaging sender id here",
      projectId: "weather-f8b1d",
    ),
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
          title: 'Flutter Weather',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.blue),
              elevation: 0,
            ),
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               return HomeScreen();
              } else {
              return  LoginScreen();
              }
            },
          )
          // routes: {
          //   WeeklyScreen.routeName: (ctx) => WeeklyScreen(),
          // },
          // onGenerateRoute: (settings) {
          //   final arguments = settings.arguments;
          //   if (settings.name == SevenDayForecastDetail.routeName) {
          //     return PageRouteBuilder(
          //       settings: settings,
          //       pageBuilder: (_, __, ___) => SevenDayForecastDetail(
          //         initialIndex: arguments == null ? 0 : arguments as int,
          //       ),
          //       transitionsBuilder: (ctx, a, b, c) => CupertinoPageTransition(
          //         primaryRouteAnimation: a,
          //         secondaryRouteAnimation: b,
          //         linearTransition: false,
          //         child: c,
          //       ),
          //     );
          //   }
          //   // Unknown route
          //   return MaterialPageRoute(builder: (_) => HomeScreen());
          // },
          ),
    );
  }
}
