import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rent/di/app_module.dart';
import 'package:house_rent/domain/usecases/reading_use_case.dart';
import 'package:house_rent/domain/usecases/tenant_use_case.dart';
import 'package:house_rent/presentation/bloc/reading_bloc.dart';
import 'package:house_rent/presentation/bloc/tenant_bloc.dart';
import 'package:house_rent/presentation/views/screens/tenant_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TenantBloc(sl.get<TenantUseCase>()),
        ),
        BlocProvider(
          create: (context) => ReadingBloc(sl.get<ReadingUseCase>()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const TenantListScreen(),
      ),
    );
  }
}
