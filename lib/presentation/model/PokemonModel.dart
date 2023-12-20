import 'package:flutter/foundation.dart';

class PokemonModel {
  List<Pokemon> pokemon;

  PokemonModel({
    required this.pokemon,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List<Pokemon> pokemonList = (json['pokemon'] as List)
        .map((pokemonJson) => Pokemon.fromJson(pokemonJson))
        .toList();

    return PokemonModel(pokemon: pokemonList);
  }
}

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  List<Type> type;
  String height;
  String weight;
  String candy;
  int? candyCount;
  Egg egg;
  List<double>? multipliers;
  List<Type> weaknesses;
  List<Evolution>? nextEvolution;
  List<Evolution>? prevEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    this.candyCount,
    required this.egg,
    required this.multipliers,
    required this.weaknesses,
    this.nextEvolution,
    this.prevEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Implement your logic to parse JSON data and create a Pokemon instance
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: (json['type'] as List).map((type) => typeFromString(type)).toList(),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      candyCount: json['candyCount'],
      egg: eggFromString(json['egg']),

      multipliers: (json['multipliers'] as List?)?.cast<double>(),
      weaknesses: (json['weaknesses'] as List)
          .map((type) => typeFromString(type))
          .toList(),
      nextEvolution: (json['nextEvolution'] as List?)
          ?.map((evo) => Evolution.fromJson(evo))
          .toList(),
      prevEvolution: (json['prevEvolution'] as List?)
          ?.map((evo) => Evolution.fromJson(evo))
          .toList(),
    );
  }
}

class Evolution {
  String num;
  String name;

  Evolution({
    required this.num,
    required this.name,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) {
    return Evolution(
      num: json['num'],
      name: json['name'],
    );
  }
}

enum Type {
  BUG,
  DARK,
  DRAGON,
  ELECTRIC,
  FAIRY,
  FIGHTING,
  FIRE,
  FLYING,
  GHOST,
  GRASS,
  GROUND,
  ICE,
  NORMAL,
  POISON,
  PSYCHIC,
  ROCK,
  STEEL,
  WATER
}

Type typeFromString(String typeString) {
  return Type.values
      .firstWhere((e) => describeEnum(e) == typeString.toUpperCase());
}

enum Egg { NOT_IN_EGGS, OMANYTE_CANDY, THE_10_KM, THE_2_KM, THE_5_KM }

Egg eggFromString(String eggString) {
  try {
    return Egg.values
        .firstWhere((e) => describeEnum(e) == eggString.toUpperCase());
  } catch (e) {
    // Handle the case where the eggString is not a valid enum value
    return Egg
        .NOT_IN_EGGS; // You can choose a default value or handle it differently
  }
}

