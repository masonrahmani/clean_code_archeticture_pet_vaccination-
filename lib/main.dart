import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

import 'core/on_generate_route.dart';
import 'features/pet_vaccination/presentation/cubit/pet/pet_cubit.dart';
import 'features/pet_vaccination/presentation/cubit/vaccination/vaccination_cubit.dart';
import 'features/pet_vaccination/presentation/pages/pet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PetCubit>(create: (_) => di.sl<PetCubit>()),
        BlocProvider<VaccinationCubit>(
            create: (_) => di.sl<VaccinationCubit>()),
      ],
      child: MaterialApp(
        title: 'My Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return const PetPage();
          }
        },
      ),
    );
  }
}
