// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesServiceHash() => r'db56fab553dde3f2dafbe456c14e199a66bab2d5';

/// See also [favoritesService].
@ProviderFor(favoritesService)
final favoritesServiceProvider = Provider<FavoritesService>.internal(
  favoritesService,
  name: r'favoritesServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesServiceRef = ProviderRef<FavoritesService>;
String _$favoritesHash() => r'8c55e19ee78a30cecb0d2b076ce688f11e9d5c1a';

/// See also [favorites].
@ProviderFor(favorites)
final favoritesProvider = StreamProvider<Favorites>.internal(
  favorites,
  name: r'favoritesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favoritesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesRef = StreamProviderRef<Favorites>;
String _$favoritesItemsCountHash() =>
    r'c8d67d2c5fa13d83da6dec350bca0418820ad8d8';

/// See also [favoritesItemsCount].
@ProviderFor(favoritesItemsCount)
final favoritesItemsCountProvider = Provider<int>.internal(
  favoritesItemsCount,
  name: r'favoritesItemsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesItemsCountRef = ProviderRef<int>;
// String _$favoritesTotalHash() => r'620fa13b324b41b44713aede70cb19b607f395cb';

/// See also [favoritesTotal].
// @ProviderFor(favoritesTotal)
// final favoritesTotalProvider = AutoDisposeProvider<double>.internal(
//   favoritesTotal,
//   name: r'favoritesTotalProvider',
//   debugGetCreateSourceHash:
//       const bool.fromEnvironment('dart.vm.product') ? null : _$favoritesTotalHash,
//   dependencies: null,
//   allTransitiveDependencies: null,
// );

typedef FavoritesTotalRef = AutoDisposeProviderRef<double>;
String _$itemAvailableQuantityHash() =>
    r'bf8ea212feaa0322b97753a9a241cbd1da278c2f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [itemAvailableQuantity].
@ProviderFor(itemAvailableQuantity)
const itemAvailableQuantityProvider = ItemAvailableQuantityFamily();

/// See also [itemAvailableQuantity].
class ItemAvailableQuantityFamily extends Family<int> {
  /// See also [itemAvailableQuantity].
  const ItemAvailableQuantityFamily();

  /// See also [itemAvailableQuantity].
  ItemAvailableQuantityProvider call(
    Product product,
  ) {
    return ItemAvailableQuantityProvider(
      product,
    );
  }

  @override
  ItemAvailableQuantityProvider getProviderOverride(
    covariant ItemAvailableQuantityProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemAvailableQuantityProvider';
}

/// See also [itemAvailableQuantity].
class ItemAvailableQuantityProvider extends AutoDisposeProvider<int> {
  /// See also [itemAvailableQuantity].
  ItemAvailableQuantityProvider(
    Product product,
  ) : this._internal(
          (ref) => itemAvailableQuantity(
            ref as ItemAvailableQuantityRef,
            product,
          ),
          from: itemAvailableQuantityProvider,
          name: r'itemAvailableQuantityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemAvailableQuantityHash,
          dependencies: ItemAvailableQuantityFamily._dependencies,
          allTransitiveDependencies:
              ItemAvailableQuantityFamily._allTransitiveDependencies,
          product: product,
        );

  ItemAvailableQuantityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    int Function(ItemAvailableQuantityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemAvailableQuantityProvider._internal(
        (ref) => create(ref as ItemAvailableQuantityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _ItemAvailableQuantityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemAvailableQuantityProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemAvailableQuantityRef on AutoDisposeProviderRef<int> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _ItemAvailableQuantityProviderElement
    extends AutoDisposeProviderElement<int> with ItemAvailableQuantityRef {
  _ItemAvailableQuantityProviderElement(super.provider);

  @override
  Product get product => (origin as ItemAvailableQuantityProvider).product;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
