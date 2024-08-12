import 'package:ecommerce_app/src/features/favorites/application/favorites_service.dart';

import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_screen_controller.g.dart';

@riverpod
class ShoppingFavoritesScreenController
    extends _$ShoppingFavoritesScreenController {
  @override
  FutureOr<void> build() {}

  FavoritesService get favoritesService => ref.read(favoritesServiceProvider);

  Future<void> removeItemById(ProductID productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => favoritesService.removeItemById(productId));
  }
}
