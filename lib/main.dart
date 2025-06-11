import  'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/features/home/home_cubit/home_cubit.dart';

import '/models/doctor_list_provider.dart';
import 'core/utils/app_router.dart';
import 'features/auth/auth_cubit/auth_cubit.dart';
import 'features/chat/chat_cubit/chat_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
        BlocProvider(
          create: (_) => ChatCubit(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return ChangeNotifierProvider(
            create: (BuildContext context) => DrListProvider(),
            child: MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
