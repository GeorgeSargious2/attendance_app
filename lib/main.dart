import 'package:attendance_app/modules/member_screens/layout/layout_cubit/layout_cubit.dart';
import 'package:attendance_app/shared/networks/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:attendance_app/shared/blocObserver.dart';
import 'package:attendance_app/shared/themes/app_theme_manager.dart';
import 'firebase_options.dart';
import 'modules/admin_screens/admin_cubit/admin_cubit.dart';
import 'modules/admin_screens/admin_layout/admin_layout.dart';
import 'modules/admin_screens/admin_layout/admin_layout_cubit/admin_layout_cubit.dart';
import 'modules/member_screens/member_cubit/attendance_cubit.dart';
import 'shared/networks/remote/firebase_services.dart';
import 'modules/member_screens/login_screen/login_screen.dart';
import 'modules/member_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await cacheHelper.init();
  Widget widget;
  String? token = cacheHelper.getData(key: 'token');
  String? adminToken = cacheHelper.getData(key: 'adminToken');
  print(token);
  print(adminToken);

  if (token != null) {
    widget = SplashScreen();
  } else if (adminToken != null) {
    widget = const AdminLayout();
  } else {
    widget = loginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({
    super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AttendanceCubit(FirebaseService()),
            ),
            BlocProvider(
              create: (context) => layoutCubit(),
            ),
            BlocProvider(
              create: (context) => AdminLayoutCubit(),
            ),
            BlocProvider(
              create: (context) => AdminCubit(FirebaseService()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemeManager.lightTheme,
            darkTheme: AppThemeManager.darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          ),
        );
      },
    );
  }
}
