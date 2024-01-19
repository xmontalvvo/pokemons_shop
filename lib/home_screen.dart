import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List pokedex = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset('images/pokeball.png', width: 200, fit: BoxFit.fitWidth,),
            
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Text("Cartas Pokemon Shop",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black ),)
              ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
                  children: [
            pokedex != null
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.4),
                      itemCount: pokedex.length,
                      itemBuilder: (context, index) {
                        var type = pokedex[index]['type'][0];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: type == 'Grass' ? Colors.greenAccent : type == 'Fire' ? Colors.redAccent : type == 'Water'? Colors. blue
                              : type == 'Electric' ? Colors.yellow : type == 'Rock' ? Colors.grey : type == 'Ground' ? Colors.brown
                              : type == 'Psychic' ? Colors.indigo : type == 'Fighting' ? Colors.orange : type == 'Bug' ? Colors.lightGreenAccent
                              : type == 'Ghost' ? Colors.deepPurple : type == 'Normal' ? Colors.black26 : type == 'Poison' ? Colors.deepPurpleAccent : Colors.pink,
                            ),
                            child: Stack(children: [
                              Positioned(
                                  bottom: -10,
                                  right: -10,
                                  child: Image.asset(
                                    'images/pokeball.png',
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                  )),
                              Positioned(
                                top: 20,
                                left: 10,
                                child: Text(
                                  pokedex[index]['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  ),
                              ),
                              Positioned(
                                top: 50,
                                left: 10,
                                child: Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 4, bottom: 4),
                                      child: Text(
                                        type.toString(),
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.black26,
                                    ),
                                    ),
                              ),
                              Positioned(
                                top: 85,
                                left: 10,
                                child: Text(
                                  type == 'Grass' ? '45 USD' : type == 'Fire' ? '18 USD' : type == 'Water'? '67 USD'
                                : type == 'Electric' ? '56 USD' : type == 'Rock' ? '13 USD' : type == 'Ground' ? '90 USD'
                                : type == 'Psychic' ? '12 USD' : type == 'Fighting' ? '66 USD' : type == 'Bug' ? '8 USD'
                                : type == 'Ghost' ? '33 USD' : type == 'Normal' ? '5 USD' : type == 'Poison' ? '25 USD' : '3 USD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: CachedNetworkImage(
                                      imageUrl: pokedex[index]['img'],
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                      )),
                            ]),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
                  ],
                ),
          ),
          ]
        ));
  }

  void fetchPokemonData() {
    var url = Uri.http("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });
  }
}
