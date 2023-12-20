import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc%20and%20cubit/cubit/PokemonCubit.dart';
import 'package:flutter_application_1/bloc%20and%20cubit/State/pokemonState.dart';
import 'package:flutter_application_1/presentation/HomePage/components/home.dart';
import 'package:flutter_application_1/presentation/model/PokemonModel.dart';
import 'package:shimmer/shimmer.dart';


class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.state,
  });
  final PokemonLoadedState state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //here pokemon contains the data from pokemonLoadedState
      itemCount: state.pokemon.pokemon.length ?? 0,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300, // Adjust this value based on your design
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        var pokemonList = state.pokemon.pokemon;

        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PokemonDetails(pokemonDetail: pokemonList[index]),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: const Color.fromARGB(255, 97, 173, 154).withOpacity(0.3),
            elevation: 2,
            shadowColor: Colors.black12,
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pokemonList[index].img == null ||
                          pokemonList[index].img.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Hero(

                          tag: 'pokemon_${pokemonList[index].id}',
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                const Color.fromARGB(255, 97, 173, 154)
                                    .withOpacity(0.4),
                            child: pokemonList[index].img.isEmpty
                                ? Shimmer.fromColors(
                                    baseColor: Colors.black,
                                    child: CircleAvatar(),
                                    direction: ShimmerDirection.btt,
                                    highlightColor: Colors.black12,
                                  )
                                : Image.network(
                                    pokemonList[index].img,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                          ),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    pokemonList[index].name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (Type type in pokemonList[index].type)
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Chip(
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            elevation: 6,
                            padding: const EdgeInsets.all(2),
                            label: Text(
                              describeEnum(type),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "height: ",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: pokemonList[index].height,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: " weight: ",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: pokemonList[index].weight,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
