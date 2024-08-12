import 'package:ecommerce_app/src/features/favorites/data/local/local_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastFavoritesRepository implements LocalFavoritesRepository {
  SembastFavoritesRepository(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastFavoritesRepository> makeDefault() async {
    return SembastFavoritesRepository(await createDatabase('default.db'));
  }

  static const favoritesItemsKey = 'favoritesItems';

  @override
  Future<Favorites> fetchFavorites() async {
    final favoritesJson =
        await store.record(favoritesItemsKey).get(db) as String?;
    if (favoritesJson != null) {
      return Favorites.fromJson(favoritesJson);
    } else {
      return const Favorites();
    }
  }

  @override
  Future<void> setFavorites(Favorites favorites) {
    return store.record(favoritesItemsKey).put(db, favorites.toJson());
  }

  @override
  Stream<Favorites> watchFavorites() {
    final record = store.record(favoritesItemsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return Favorites.fromJson(snapshot.value as String);
      } else {
        return const Favorites();
      }
    });
  }
}
