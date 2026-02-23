import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading_plus/flutter_easyloading_plus.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nokair_assignment/bindings/initial_binding.dart';
import 'package:nokair_assignment/flavors/build_config.dart';
import 'package:nokair_assignment/flavors/env_config.dart';
import 'package:nokair_assignment/theme/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: '.env');

  EnvConfig prodConfig = EnvConfig(baseUrl: dotenv.env['BASE_URL'] ?? '');

  BuildConfig.instantiate(envConfig: prodConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'NOK Air',
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBinding(),
          theme: ThemeData(
            fontFamily: 'Roboto',
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
            useMaterial3: true,
          ),
          home: const MainShell(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
