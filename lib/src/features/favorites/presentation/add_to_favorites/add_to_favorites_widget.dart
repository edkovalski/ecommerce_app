import 'package:ecommerce_app/src/features/favorites/application/favorites_service.dart';
import 'package:ecommerce_app/src/features/favorites/presentation/add_to_favorites/add_to_favorites_controller.dart';
import 'package:ecommerce_app/src/features/favorites/presentation/favorites/favorites_screen_controller.dart';

import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToFavoritesWidget extends ConsumerWidget {
  const AddToFavoritesWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      addToFavoritesControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen<AsyncValue>(
      shoppingFavoritesScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final availableQuantity = ref.watch(itemAvailableQuantityProvider(product));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        gapH8,
        PrimaryButtonTwo(
          icon: availableQuantity > 0
              ? const Icon(Icons.favorite_border)
              : const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
          onPressed: availableQuantity > 0
              ? () => ref
                  .read(addToFavoritesControllerProvider.notifier)
                  .addItem(product.id)
              : () => ref
                  .read(shoppingFavoritesScreenControllerProvider.notifier)
                  .removeItemById(product.id),
        )
      ],
    );
  }
}
