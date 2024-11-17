import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:invman/model/repo/auth.dart';
import 'package:invman/presentation/layout/start_screen.dart';
import 'package:invman/presentation/theme/theme.dart';
import 'package:invman/test_database.dart';
import 'bloc/app_cubit.dart';
// import 'package:flutter_todo/realm/realm_services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..initialSetup(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InvMan',
        theme: lightTheme,
        // theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
        darkTheme: darkTheme,
        // darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
        themeMode: ThemeMode.dark,
        home:   StartScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
