import 'dart:math';

import 'package:ecommerce_app/src/exceptions/error_logger.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/favorites/data/local/local_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/data/remote/remote_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';

import 'package:ecommerce_app/src/features/favorites/domain/item.dart';
import 'package:ecommerce_app/src/features/favorites/domain/mutable_cart.dart';

import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_sync_service.g.dart';

class FavoritesSyncService {
  FavoritesSyncService(this.ref) {
    _init();
  }
  final Ref ref;

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      if (previousUser == null && user != null) {
        _moveItemsToRemoteFavorites(user.uid);
      }
    });
  }

  Future<void> _moveItemsToRemoteFavorites(String uid) async {
    try {
      final localFavoritesRepository =
          ref.read(localFavoritesRepositoryProvider);
      final localFavorites = await localFavoritesRepository.fetchFavorites();
      if (localFavorites.items.isNotEmpty) {
        final remoteFavoritesRepository =
            ref.read(remoteFavoritesRepositoryProvider);
        final remoteFavorites =
            await remoteFavoritesRepository.fetchFavorites(uid);
        final localItemsToAdd =
            await _getLocalItemsToAdd(localFavorites, remoteFavorites);
        final updatedRemoteFavorites =
            remoteFavorites.addItems(localItemsToAdd);
        await remoteFavoritesRepository.setFavorites(
            uid, updatedRemoteFavorites);
        await localFavoritesRepository.setFavorites(const Favorites());
      }
    } catch (e, st) {
      ref.read(errorLoggerProvider).logError(e, st);
    }
  }

  Future<List<Item>> _getLocalItemsToAdd(
      Favorites localFavorites, Favorites remoteFavorites) async {
    final productsRepository = ref.read(productsRepositoryProvider);
    final products = await productsRepository.fetchProductsList();
    final localItemsToAdd = <Item>[];
    for (final localItem in localFavorites.items.entries) {
      final productId = localItem.key;
      final localQuantity = localItem.value;
      final remoteQuantity = remoteFavorites.items[productId] ?? 0;
      final product = products.firstWhere((product) => product.id == productId);
      final cappedLocalQuantity = min(
        localQuantity,
        product.availableQuantity - remoteQuantity,
      );
      if (cappedLocalQuantity > 0) {
        localItemsToAdd
            .add(Item(productId: productId, quantity: cappedLocalQuantity));
      }
    }
    return localItemsToAdd;
  }
}

@Riverpod(keepAlive: true)
FavoritesSyncService favoritesSyncService(FavoritesSyncServiceRef ref) {
  return FavoritesSyncService(ref);
}
