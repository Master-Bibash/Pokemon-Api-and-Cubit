import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc%20and%20cubit/cubit/PokemonCubit.dart';
import 'package:flutter_application_1/bloc%20and%20cubit/State/pokemonState.dart';
import 'package:flutter_application_1/presentation/InfoPage/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PokeMonCard extends StatefulWidget {
  const PokeMonCard({super.key});

  @override
  State<PokeMonCard> createState() => _PokeMonCardState();
}

class _PokeMonCardState extends State<PokeMonCard> {
//so the link of URl is here so we make PokemonCubit as late
  late PokemonCubit pokemonCubit;
  @override
  void initState() {
    super.initState();
    //context allows you to access various services and objects related to current widget
    //read<PokemonCubit>() allows u to retrieve instance of particular type here the nearest ancestor "BlocProvider" or 'reposotory' is up widget tree.
    pokemonCubit = context.read<PokemonCubit>();
    pokemonCubit.fetchData(); //fetch the data from API
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pokemonCubit.close(); //dispose the data
    super.dispose();
  }

  @override
  //so basically BuildContext contains information about location in widget tree.
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        //so when the state is inital show shimmer effect
        if (state is PokemonInitialState) {
          return Shimmer.fromColors(
              enabled: true,
              baseColor: Colors.black54.withOpacity(0.9),
              highlightColor: Colors.black12,
              direction: ShimmerDirection.ttb,
              loop: 100, //added loop
              child: Center(
                  child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.all(2),
                color: Colors.red,
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              )));

          //if loading state
        } else if (state is PokemonLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //finally when pokemonisLoaded
        else if (state is PokemonLoadedState) {
          return RefreshIndicator(
              onRefresh: () async {
                pokemonCubit.fetchData();
              },
              child: Body(
                state: state,
              ));
          //if the state is error
        } else if (state is PokemonErrorState) {
          return Center(
            child: Text('Error :${state.error}'),
          );
        } else {
          return Container();
        }
      },
    )));
  }
}

