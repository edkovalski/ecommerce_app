import 'package:ecommerce_app/src/features/favorites/application/favorites_service.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShoppingFavoritesIcon extends ConsumerWidget {
  const ShoppingFavoritesIcon({super.key});

  static const shoppingFavoritesIconKey = Key('shopping-favorites');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesItemsCount = ref.watch(favoritesItemsCountProvider);
    return Stack(
      children: [
        Center(
          child: IconButton(
            key: shoppingFavoritesIconKey,
            icon: const Icon(Icons.favorite),
            onPressed: () => context.goNamed(AppRoute.favorites.name),
          ),
        ),
        if (favoritesItemsCount > 0)
          Positioned(
            top: Sizes.p4,
            right: Sizes.p4,
            child: ShoppingFavoritesIconBadge(itemsCount: favoritesItemsCount),
          ),
      ],
    );
  }
}

class ShoppingFavoritesIconBadge extends StatelessWidget {
  const ShoppingFavoritesIconBadge({super.key, required this.itemsCount});
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.p16,
      height: Sizes.p16,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$itemsCount',
          textAlign: TextAlign.center,
          textScaler: const TextScaler.linear(1.0),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
