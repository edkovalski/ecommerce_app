import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecommerce_app/src/features/favorites/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class Favorites {
  const Favorites([this.items = const {}]);

  final Map<ProductID, int> items;

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map) {
    return Favorites(
      Map<ProductID, int>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorites.fromJson(String source) =>
      Favorites.fromMap(json.decode(source));

  @override
  String toString() => 'Favorites(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favorites && mapEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

extension FavoritesItems on Favorites {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(
        productId: entry.key,
        quantity: entry.value,
      );
    }).toList();
  }
}
