import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuk_baca_quran/core/di_getit/service_locator.dart';
import 'package:yuk_baca_quran/core/navigation/app_router.dart';
import 'package:yuk_baca_quran/core/navigation/navigation_service.dart';
import 'package:yuk_baca_quran/ui/home/cubit/home_cubit.dart';
import 'package:yuk_baca_quran/ui/home/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(providers:[
      BlocProvider(create: (context) => sl<HomeCubit>()..fetchSurat(),),
    ] , child: 
    MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRouter.onGenerateRoute,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeView(),
    )
    );
  }
}
