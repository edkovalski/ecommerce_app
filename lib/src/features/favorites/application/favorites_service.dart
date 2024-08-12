import 'dart:math';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/favorites/data/local/local_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/data/remote/remote_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';

import 'package:ecommerce_app/src/features/favorites/domain/item.dart';
import 'package:ecommerce_app/src/features/favorites/domain/mutable_cart.dart';

import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_service.g.dart';

class FavoritesService {
  FavoritesService(this.ref);
  final Ref ref;

  Future<Favorites> _fetchFavorites() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref
          .read(remoteFavoritesRepositoryProvider)
          .fetchFavorites(user.uid);
    } else {
      return ref.read(localFavoritesRepositoryProvider).fetchFavorites();
    }
  }

  Future<void> _setFavorites(Favorites favorites) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref
          .read(remoteFavoritesRepositoryProvider)
          .setFavorites(user.uid, favorites);
    } else {
      await ref.read(localFavoritesRepositoryProvider).setFavorites(favorites);
    }
  }

  Future<void> addItem(Item item) async {
    final favorites = await _fetchFavorites();
    final updated = favorites.addItem(item);
    await _setFavorites(updated);
  }

  Future<void> removeItemById(ProductID productId) async {
    final favorites = await _fetchFavorites();
    final updated = favorites.removeItemById(productId);
    await _setFavorites(updated);
  }
}

@Riverpod(keepAlive: true)
FavoritesService favoritesService(FavoritesServiceRef ref) {
  return FavoritesService(ref);
}

@Riverpod(keepAlive: true)
Stream<Favorites> favorites(FavoritesRef ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(remoteFavoritesRepositoryProvider)
        .watchFavorites(user.uid);
  } else {
    return ref.watch(localFavoritesRepositoryProvider).watchFavorites();
  }
}

@Riverpod(keepAlive: true)
int favoritesItemsCount(FavoritesItemsCountRef ref) {
  return ref.watch(favoritesProvider).maybeMap(
        data: (favorites) => favorites.value.items.length,
        orElse: () => 0,
      );
}

@riverpod
int itemAvailableQuantity(ItemAvailableQuantityRef ref, Product product) {
  final favorites = ref.watch(favoritesProvider).value;
  if (favorites != null) {
    final quantity = favorites.items[product.id] ?? 0;
    return max(0, product.availableQuantity - quantity);
  } else {
    return product.availableQuantity;
  }
}
