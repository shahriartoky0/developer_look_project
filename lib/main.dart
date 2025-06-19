import 'package:developper_look/utilities/app_constants.dart';
import 'package:developper_look/utilities/app_theme.dart';
import 'package:developper_look/views/screens/auth/sign_in_page.dart';
import 'package:developper_look/views/screens/feed/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/post_card_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConstants.supaBaseProjectKey,
    anonKey: AppConstants.supaBaseAnonKey,
  );
  //final supabase = Supabase.instance.client;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SignInPage(),
      theme: AppTheme.defaultThemeData,
      initialBinding: ControllerBinder(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CardController());
  }
}
