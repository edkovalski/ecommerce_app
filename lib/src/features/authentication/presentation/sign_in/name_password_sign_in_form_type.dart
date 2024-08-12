/// Form type for name & password authentication
enum NamePasswordSignInFormType { signIn, register }

extension NamePasswordSignInFormTypeX on NamePasswordSignInFormType {
  String get passwordLabelText {
    if (this == NamePasswordSignInFormType.register) {
      return 'Пароль (4+ знаков)';
    } else {
      return 'Пароль';
    }
  }

  // Getters
  String get primaryButtonText {
    if (this == NamePasswordSignInFormType.register) {
      return 'Создать аккаунт';
    } else {
      return 'Войти в аккаунт';
    }
  }

  String get secondaryButtonText {
    if (this == NamePasswordSignInFormType.register) {
      return 'У вас есть аккаунт? Войдите';
    } else {
      return 'Нужен аккаунт? Зарегистрируйтесь';
    }
  }

  NamePasswordSignInFormType get secondaryActionFormType {
    if (this == NamePasswordSignInFormType.register) {
      return NamePasswordSignInFormType.signIn;
    } else {
      return NamePasswordSignInFormType.register;
    }
  }

  String get errorAlertTitle {
    if (this == NamePasswordSignInFormType.register) {
      return 'Регистрация не удалась';
    } else {
      return 'Не удалось войти в аккаунт';
    }
  }

  String get title {
    if (this == NamePasswordSignInFormType.register) {
      return 'Регистрация';
    } else {
      return 'Войти в аккаунт';
    }
  }
}
