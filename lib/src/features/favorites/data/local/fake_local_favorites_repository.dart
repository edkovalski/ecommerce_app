import 'package:ecommerce_app/src/features/favorites/data/local/local_favorites_repository.dart';

import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';

import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeLocalFavoritesRepository implements LocalFavoritesRepository {
  FakeLocalFavoritesRepository({this.addDelay = true});
  final bool addDelay;

  final _favorites = InMemoryStore<Favorites>(const Favorites());

  @override
  Future<Favorites> fetchFavorites() => Future.value(_favorites.value);

  @override
  Stream<Favorites> watchFavorites() => _favorites.stream;

  @override
  Future<void> setFavorites(Favorites favorites) async {
    await delay(addDelay);
    _favorites.value = favorites;
  }
}
