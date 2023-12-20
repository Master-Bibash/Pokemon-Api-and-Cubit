import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc%20and%20cubit/cubit/PokemonCubit.dart';
import 'package:flutter_application_1/presentation/InfoPage/components/Home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // initialization cubit here in blocProvider
      providers: [
        BlocProvider<PokemonCubit>(
          create: (context) => PokemonCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: const PokeMonCard(),
      ),
    );
  }
}
