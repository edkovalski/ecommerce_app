import 'dart:async';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_form_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'name_password_sign_in_controller.g.dart';

@riverpod
class NamePasswordSignInController extends _$NamePasswordSignInController {
  @override
  FutureOr<void> build() {}
  Future<bool> submit(
      {required String name,
      required String password,
      required NamePasswordSignInFormType formType}) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => _authenticate(name, password, formType));
    return state.hasError == false;
  }

  Future<void> _authenticate(
      String name, String password, NamePasswordSignInFormType formType) {
    final authRepository = ref.read(authRepositoryProvider);
    switch (formType) {
      case NamePasswordSignInFormType.signIn:
        return authRepository.signInWithNameAndPassword(name, password);
      case NamePasswordSignInFormType.register:
        return authRepository.createUserWithNameAndPassword(name, password);
    }
  }
}
