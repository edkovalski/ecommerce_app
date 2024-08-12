import 'package:ecommerce_app/src/features/favorites/data/remote/fake_remote_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_favorites_repository.g.dart';

abstract class RemoteFavoritesRepository {
  Future<Favorites> fetchFavorites(String uid);

  Stream<Favorites> watchFavorites(String uid);

  Future<void> setFavorites(String uid, Favorites favorites);
}

@Riverpod(keepAlive: true)
RemoteFavoritesRepository remoteFavoritesRepository(
    RemoteFavoritesRepositoryRef ref) {
  return FakeRemoteFavoritesRepository(addDelay: false);
}
