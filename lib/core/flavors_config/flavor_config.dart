enum Flavor {
  starReward,
  senseOfTaste,
  qantum,
  qantumClub,
  maxx,
  mhbc,
  clh,
  montaukTavern,
  hogansReward,
  northShoreTavern,
  aceRewards,
  queens,
  brisbane,
  woollahra,
  bluewater,
  flinders,
  kingscliff
}

class FlavorValues {
  String? appName;
  String? appVersion;

  FlavorValues({this.appName, this.appVersion});
}

class FlavorConfig {
  final Flavor? flavor;
  final FlavorValues flavorValues;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor, required FlavorValues flavorValues}) {
    _instance ??= FlavorConfig._internal(flavor, flavorValues);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.flavorValues);

  static FlavorConfig get instance {
    return _instance!;
  }
}
