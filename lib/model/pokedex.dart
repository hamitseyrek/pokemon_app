import 'dart:convert';

Pokedex pokedexFromJson(String str) {
  final jsonData = json.decode(str);
  return Pokedex.fromJson(jsonData);
}

String pokedexToJson(Pokedex data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Pokedex {
  List<Pokemon>? pokemon;

  Pokedex({
    this.pokemon,
  });

  factory Pokedex.fromJson(Map<String, dynamic> json) => Pokedex(
        pokemon: json["pokemon"] == null
            ? null
            : List<Pokemon>.from(
                json["pokemon"].map((x) => Pokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pokemon": pokemon == null
            ? null
            : List<dynamic>.from(pokemon!.map((x) => x.toJson())),
      };
}

class Pokemon {
  int? id;
  String? num;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  int? candyCount;
  String? egg;
  double? spawnChance;
  double? avgSpawns;
  String? spawnTime;
  List<double>? multipliers;
  List<String>? weaknesses;
  List<Evolution>? nextEvolution;
  List<Evolution>? prevEvolution;

  Pokemon({
    this.id,
    this.num,
    this.name,
    this.img,
    this.type,
    this.height,
    this.weight,
    this.candy,
    this.candyCount,
    this.egg,
    this.spawnChance,
    this.avgSpawns,
    this.spawnTime,
    this.multipliers,
    this.weaknesses,
    this.nextEvolution,
    this.prevEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        num: json["num"],
        name: json["name"],
        img: json["img"],
        type: json["type"] == null
            ? null
            : List<String>.from(json["type"].map((x) => x)),
        height: json["height"],
        weight: json["weight"],
        candy: json["candy"],
        candyCount: json["candy_count"],
        egg: json["egg"],
        spawnChance: json["spawn_chance"] == null
            ? null
            : json["spawn_chance"].toDouble(),
        avgSpawns:
            json["avg_spawns"] == null ? null : json["avg_spawns"].toDouble(),
        spawnTime: json["spawn_time"],
        multipliers: json["multipliers"] == null
            ? null
            : List<double>.from(json["multipliers"].map((x) => x.toDouble())),
        weaknesses: json["weaknesses"] == null
            ? null
            : List<String>.from(json["weaknesses"].map((x) => x)),
        nextEvolution: json["next_evolution"] == null
            ? null
            : List<Evolution>.from(
                json["next_evolution"].map((x) => Evolution.fromJson(x))),
        prevEvolution: json["prev_evolution"] == null
            ? null
            : List<Evolution>.from(
                json["prev_evolution"].map((x) => Evolution.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "num": num,
        "name": name,
        "img": img,
        "type": type == null ? null : List<dynamic>.from(type!.map((x) => x)),
        "height": height,
        "weight": weight,
        "candy": candy,
        "candy_count": candyCount,
        "egg": egg,
        "spawn_chance": spawnChance,
        "avg_spawns": avgSpawns,
        "spawn_time": spawnTime,
        "multipliers": multipliers == null
            ? null
            : List<dynamic>.from(multipliers!.map((x) => x)),
        "weaknesses": weaknesses == null
            ? null
            : List<dynamic>.from(weaknesses!.map((x) => x)),
        "next_evolution": nextEvolution == null
            ? null
            : List<dynamic>.from(nextEvolution!.map((x) => x.toJson())),
        "prev_evolution": prevEvolution == null
            ? null
            : List<dynamic>.from(prevEvolution!.map((x) => x.toJson())),
      };
}

class Evolution {
  String? num;
  String? name;

  Evolution({
    this.num,
    this.name,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        num: json["num"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "name": name,
      };
}
