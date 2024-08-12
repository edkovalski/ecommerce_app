import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';

import 'package:ecommerce_app/src/features/favorites/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

extension MutableFavorites on Favorites {
  Favorites setItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy[item.productId] = item.quantity;
    return Favorites(copy);
  }

  Favorites addItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy.update(
      item.productId,
      (value) => item.quantity + value,
      ifAbsent: () => item.quantity,
    );
    return Favorites(copy);
  }

  Favorites addItems(List<Item> itemsToAdd) {
    final copy = Map<ProductID, int>.from(items);
    for (var item in itemsToAdd) {
      copy.update(
        item.productId,
        (value) => item.quantity + value,
        ifAbsent: () => item.quantity,
      );
    }
    return Favorites(copy);
  }

  Favorites removeItemById(ProductID productId) {
    final copy = Map<ProductID, int>.from(items);
    copy.remove(productId);
    return Favorites(copy);
  }
}
