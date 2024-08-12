sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

class NameAlreadyInUseException extends AppException {
  NameAlreadyInUseException()
      : super('name-already-in-use', 'это имя уже используется');
}

class WeakPasswordException extends AppException {
  WeakPasswordException() : super('weak-password', 'Слишком короткий пароль');
}

class WrongPasswordException extends AppException {
  WrongPasswordException() : super('wrong-password', 'Неправильный пароль');
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'Пользователь не найден');
}
