import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_favorites_repository.g.dart';

abstract class LocalFavoritesRepository {
  Future<Favorites> fetchFavorites();

  Stream<Favorites> watchFavorites();

  Future<void> setFavorites(Favorites favorites);
}

@Riverpod(keepAlive: true)
LocalFavoritesRepository localFavoritesRepository(
    LocalFavoritesRepositoryRef ref) {
  throw UnimplementedError();
}
