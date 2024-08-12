import 'package:ecommerce_app/src/features/favorites/data/remote/remote_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeRemoteFavoritesRepository implements RemoteFavoritesRepository {
  FakeRemoteFavoritesRepository({this.addDelay = true});
  final bool addDelay;

  final _favoritess = InMemoryStore<Map<String, Favorites>>({});

  @override
  Future<Favorites> fetchFavorites(String uid) {
    return Future.value(_favoritess.value[uid] ?? const Favorites());
  }

  @override
  Stream<Favorites> watchFavorites(String uid) {
    return _favoritess.stream
        .map((favoritesData) => favoritesData[uid] ?? const Favorites());
  }

  @override
  Future<void> setFavorites(String uid, Favorites favorites) async {
    await delay(addDelay);
    final favoritess = _favoritess.value;
    favoritess[uid] = favorites;
    _favoritess.value = favoritess;
  }
}
