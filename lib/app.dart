import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, GoogleAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tok_tok_app/manager/firebase_auth_client.dart';
import 'package:tok_tok_app/pages/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuthClient authClient = Get.find();
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      initialRoute: authClient.isSignedIn ? AppRoutes.home : AppRoutes.signIn,
      onGenerateTitle: (context) => 'TokTok',
      onGenerateRoute: AppRoutes.onGenerateRoute,
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

class AppRoutes {
  static const String signIn = '/signIn';
  static const String profile = '/profile';
  static const String home = '/home';

  //Implement onGenerateRoute method
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext _) => SignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
            ],
          ),
        );
      case profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext _) => ProfileScreen(
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, signIn);
              }),
            ],
          ),
        );
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext _) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext _) => SignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, home);
              }),
            ],
          ),
        );
    }
  }
}
