import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, GoogleAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                print('Signed in');
                Navigator.pushReplacementNamed(context, '/profile');
              }),
            ],
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
      },
      onGenerateTitle: (context) => 'TokTok',
      // onGenerateRoute: AppRoutes.onGenerateRoute,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 720),
          builder: (_, __) => Scaffold(
            body: SafeArea(child: child!),
          ),
        );
      },
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

// class AppRoutes {
//   static const String login = '/login';
//
//   static Map<String, Widget Function(BuildContext)> routes() {
//     return {
//       login: (context) => const LoginPage(),
//     };
//   }
//
//   //Implement onGenerateRoute method
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       default:
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (BuildContext _) => const LoginPage(),
//         );
//     }
//   }
// }
