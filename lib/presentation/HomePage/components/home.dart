import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/model/PokemonModel.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({super.key, required this.pokemonDetail});
  final Pokemon? pokemonDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.10),
        appBar: AppBar(
          
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left_sharp,
                color: Colors.white,
                size: 30,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent.withOpacity(0.1),
          title: const Text(
            "Pokemon Card",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.white),
          ),
        ),
        body: pokemonDetail!.img.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Positioned(
                      child: Container(
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.1),
                  )),
                  Positioned(
                      top: 110,
                      left: 22,
                      child: Container(
                        
                        width: MediaQuery.of(context).size.width * 0.90,
                        padding: const EdgeInsets.all(6),
                        child: Card(
                          elevation: 17,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius:
                                BorderRadius.circular(30.0), //<-- SEE HERE
                          ),
                          child: Wrap(
                            children: [
                              Column(
                                children: [
                                  Hero(
                                    tag: 'disISNp',
                                    child: CircleAvatar(
                                      radius: 85,
                                      backgroundImage:
                                          NetworkImage(pokemonDetail!.img),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 40),
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.blue.withOpacity(0.2)
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, left: 30, bottom: 2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DetailsMethod(
                                            pokemonDetail: pokemonDetail,
                                            answer: pokemonDetail!.name,
                                            topic: "Name: "),
                                        Text(
                                          "Type: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black.withOpacity(0.8),
                                              fontFamily: "Poppins"),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            for (Type type in pokemonDetail!.type)
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Chip(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.3),
                                                    elevation: 6,
                                                    padding: const EdgeInsets.all(2),
                                                    label:
                                                        Text(describeEnum(type))),
                                              )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Weakness: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black.withOpacity(0.8),
                                              fontFamily: "Poppins"),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                           
                                            for (Type weakness
                                                in pokemonDetail!.weaknesses)
                                                
                                              
                                              Padding(
                                                
                                                padding: const EdgeInsets.all(2),
                                                child: Chip(
                                                  
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.3),
                                                    elevation: 6,
                                                    padding: const EdgeInsets.all(2),
                                                    label: Text(
                                                    
                                                        describeEnum(weakness),style: TextStyle(fontSize: 12),)),
                                              )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailsMethod(
                                            pokemonDetail: pokemonDetail,
                                            topic: "Height",
                                            answer: pokemonDetail!.height),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailsMethod(
                                            pokemonDetail: pokemonDetail,
                                            topic: "Weight",
                                            answer: pokemonDetail!.weight),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Wrap(
                                          children: [
                                            DetailsMethod(
                                                pokemonDetail: pokemonDetail,
                                                topic: "Candy",
                                                answer: pokemonDetail!.candy),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ));
  }
}

class DetailsMethod extends StatelessWidget {
  const DetailsMethod({
    super.key,
    required this.pokemonDetail,
    required this.topic,
    required this.answer,
  });
  final String topic;
  final String answer;

  final Pokemon? pokemonDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$topic: ",
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black.withOpacity(0.8),
              fontFamily: "Poppins"),
        ),
        Text(
          answer,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black.withOpacity(0.8),
              fontFamily: "Poppins"),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
