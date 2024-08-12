import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_form_type.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/string_validators.dart';

mixin NameAndPasswordValidators {
  final StringValidator nameSubmitValidator = NameSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(4);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();

  bool canSubmitName(String name) {
    return nameSubmitValidator.isValid(name);
  }

  bool canSubmitPassword(String password, NamePasswordSignInFormType formType) {
    if (formType == NamePasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  String? nameErrorText(String name) {
    final bool showErrorText = !canSubmitName(name);
    final String errorText =
        name.isEmpty ? 'Name can\'t be empty' : 'Invalid name';
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(
      String password, NamePasswordSignInFormType formType) {
    final bool showErrorText = !canSubmitPassword(password, formType);
    final String errorText =
        password.isEmpty ? 'Password can\'t be empty' : 'Password is too short';
    return showErrorText ? errorText : null;
  }
}
