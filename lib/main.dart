import 'package:ecommerce_app/src/app.dart';

import 'package:ecommerce_app/src/features/favorites/application/favorites_sync_service.dart';
import 'package:ecommerce_app/src/features/favorites/data/local/local_favorites_repository.dart';
import 'package:ecommerce_app/src/features/favorites/data/local/sembast_favorites_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localFavoritesRepository =
      await SembastFavoritesRepository.makeDefault();

  final container = ProviderContainer(
    overrides: [
      localFavoritesRepositoryProvider
          .overrideWithValue(localFavoritesRepository),
    ],
  );
  container.read(favoritesSyncServiceProvider);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}
