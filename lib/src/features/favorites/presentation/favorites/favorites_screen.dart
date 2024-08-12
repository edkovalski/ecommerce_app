import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/features/favorites/application/favorites_service.dart';
import 'package:ecommerce_app/src/features/favorites/domain/favorites.dart';
import 'package:ecommerce_app/src/features/favorites/presentation/favorites/favorites_item.dart';
import 'package:ecommerce_app/src/features/favorites/presentation/favorites/favorites_items_builder.dart';
import 'package:ecommerce_app/src/features/favorites/presentation/favorites/favorites_screen_controller.dart';

import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingFavoritesScreen extends ConsumerWidget {
  const ShoppingFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      shoppingFavoritesScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final favoritesValue = ref.watch(favoritesProvider);
          return AsyncValueWidget<Favorites>(
            value: favoritesValue,
            data: (favorites) => ShoppingFavoritesItemsBuilder(
              items: favorites.toItemsList(),
              itemBuilder: (_, item, index) => FavoritesItem(
                item: item,
                itemIndex: index,
              ),
            ),
          );
        },
      ),
    );
  }
}
