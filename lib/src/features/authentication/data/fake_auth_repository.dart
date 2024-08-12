import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/domain/fake_app_user.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_auth_repository.g.dart';

class FakeAuthRepository {
  FakeAuthRepository({this.addDelay = true});
  final bool addDelay;
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  final List<FakeAppUser> _users = [
    FakeAppUser(uid: 'test', name: 'test', password: 'test')
  ];

  Future<void> signInWithNameAndPassword(String name, String password) async {
    await delay(addDelay);
    for (final u in _users) {
      if (u.name == name && u.password == password) {
        _authState.value = u;
        return;
      }
      if (u.name == name && u.password != password) {
        throw WrongPasswordException();
      }
    }
    throw UserNotFoundException();
  }

  Future<void> createUserWithNameAndPassword(
      String name, String password) async {
    await delay(addDelay);
    for (final u in _users) {
      if (u.name == name) {
        throw NameAlreadyInUseException();
      }
    }
    if (password.length <= 3) {
      throw WeakPasswordException();
    }
    _createNewUser(name, password);
  }

  Future<void> signOut() async {
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String name, String password) {
    final user = FakeAppUser(
      uid: name.split('').reversed.join(),
      name: name,
      password: password,
    );
    _users.add(user);
    _authState.value = user;
  }
}

@Riverpod(keepAlive: true)
FakeAuthRepository authRepository(AuthRepositoryRef ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
