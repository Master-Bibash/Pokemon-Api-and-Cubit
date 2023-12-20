import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/bloc%20and%20cubit/State/pokemonState.dart';
import 'package:flutter_application_1/presentation/model/PokemonModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitialState());
  var url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

//Future caz the data has to be read late
  Future<void> fetchData() async {
    emit(PokemonLoadingState());

    try {
      var res = await http.get(Uri.parse(url));
   // res is the instance of response
   //res.body has all the data and is of string type
      print("res value is ${json.decode(res.body).runtimeType}");  
      if (res.statusCode == 200) {
        //here we convert the string(res.body) to Map<String,dynamic>
        //the data has the all the Map data
        final Map<String, dynamic> data = json.decode(res.body);
        //here we convert the data into Dart instance using fromJson
        emit(PokemonLoadedState(PokemonModel.fromJson(data)));
      } else {
        // Handle HTTP error
        emit(PokemonErrorState(
            'Failed to fetch Pokemon data. HTTP Status Code: ${res.statusCode}'));
      }
    } catch (e) {
      // Handle other exceptions
      emit(PokemonErrorState('Failed to fetch Pokemon data. Error: $e'));
    }
  }
}
