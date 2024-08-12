import 'package:ecommerce_app/src/features/favorites/application/favorites_service.dart';
import 'package:ecommerce_app/src/features/favorites/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_to_favorites_controller.g.dart';

@riverpod
class AddToFavoritesController extends _$AddToFavoritesController {
  @override
  FutureOr<void> build() {}

  Future<void> addItem(ProductID productId) async {
    final favoritesService = ref.read(favoritesServiceProvider);
    final quantity = ref.read(itemQuantityControllerProvider);
    final item = Item(productId: productId, quantity: quantity);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(() => favoritesService.addItem(item));
    if (!state.hasError) {
      ref.read(itemQuantityControllerProvider.notifier).updateQuantity(1);
    }
  }
}

@riverpod
class ItemQuantityController extends _$ItemQuantityController {
  @override
  int build() {
    return 1;
  }

  void updateQuantity(int quantity) {
    state = quantity;
  }
}
