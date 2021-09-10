import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/pokemon_detail.dart';

import 'model/pokedex.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex? pokedex;
  Future<Pokedex>? data;

  Future<Pokedex> getPokemons() async {
    var response = await http.get(Uri.parse(url));
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex!;
  }

  @override
  void initState() {
    super.initState();
    data = getPokemons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<Pokedex> snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapShot.connectionState == ConnectionState.done) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: snapShot.data!.pokemon!.map((poke) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: poke,
                                  )));
                        },
                        child: Hero(
                          tag: poke.img!,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    height: 120,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/loading.gif",
                                      image: poke.img!,
                                    ),
                                  ),
                                ),
                                Text(
                                  poke.name!,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  throw Exception('hata1111');
                }
              });
        } else {
          return FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<Pokedex> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
//              return GridView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2), itemBuilder: (context, index) {
//                return Text(gelenPokedex.data.pokemon[index].name);
//              });

                  return GridView.extent(
                    maxCrossAxisExtent: 300,
                    children: snapshot.data!.pokemon!.map((poke) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: poke,
                                  )));
                        },
                        child: Hero(
                            tag: poke.img!,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/loading.gif",
                                      image: poke.img!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    poke.name!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                      );
                    }).toList(),
                  );
                } else {
                  throw Exception('hata111122222');
                }
              });
        }
      }),
    );
  }
}
