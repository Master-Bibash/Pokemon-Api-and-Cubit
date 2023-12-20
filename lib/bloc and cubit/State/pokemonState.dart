//define events
import 'package:flutter_application_1/presentation/model/PokemonModel.dart';



//define states
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  //so basically when we call state the pokemon comes there
  final PokemonModel pokemon;
  PokemonLoadedState(this.pokemon);
}

class PokemonErrorState extends PokemonState {
  final String error;
  PokemonErrorState(this.error);
}
