import 'flavor_config.dart';

class AppConfig {
  static const Map<Flavor, String> _appIds = {
    Flavor.qantum: '6740079667',
    Flavor.qantumClub: '6740079667',
    Flavor.mhbc: '6746117250',
    Flavor.brisbane: '6755106848',
    Flavor.clh: '6747386436',
    Flavor.drinkRewards: '6758339982',
    Flavor.bluewater: '6755418847',
    Flavor.edp: '6760811723',
    Flavor.flinders: '6755678758',
    Flavor.hogansReward: '6751805052',
    Flavor.mosaic: '6764030789',
    Flavor.mannumClub: '6766842012',
    Flavor.kingscliff: '6758032447',
    Flavor.maxx: '6742400963',
    Flavor.maxClub: '6759371812',
    Flavor.montaukTavern: '6747889055',
    Flavor.starReward: '6743517123',
    Flavor.wonthaggi: '6759718908',
    Flavor.bobsBulkBooze: '1511117781',
    Flavor.northShoreTavern: '6753587248',
    Flavor.woollahra: '6755174321',
    Flavor.southportSharks: '6783259087',
  };

  static String get iosAppStoreUrl {
    final id = appId;
    return 'https://apps.apple.com/app/id$id';
  }

  static String get appId {
    final flavor = FlavorConfig.instance.flavor;
    if (flavor == null) {
      // Replace fallback behavior with a thrown error if you prefer fail-fast.
      return _appIds[Flavor.qantum]!;
    }
    return _appIds[flavor] ?? _appIds[Flavor.qantum]!;
  }
}
