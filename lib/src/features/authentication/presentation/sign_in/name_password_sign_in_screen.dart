import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_form_type.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/name_password_sign_in_validators.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/string_validators.dart';

import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce_app/src/common_widgets/custom_text_button.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NamePasswordSignInScreen extends StatelessWidget {
  const NamePasswordSignInScreen({super.key, required this.formType});
  final NamePasswordSignInFormType formType;

  static const nameKey = Key('name');
  static const passwordKey = Key('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Войти в аккаунт')),
      body: NamePasswordSignInContents(
        formType: formType,
      ),
    );
  }
}

class NamePasswordSignInContents extends ConsumerStatefulWidget {
  const NamePasswordSignInContents({
    super.key,
    this.onSignedIn,
    required this.formType,
  });
  final VoidCallback? onSignedIn;

  final NamePasswordSignInFormType formType;
  @override
  ConsumerState<NamePasswordSignInContents> createState() =>
      _NamePasswordSignInContentsState();
}

class _NamePasswordSignInContentsState
    extends ConsumerState<NamePasswordSignInContents>
    with NameAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  String get name => _nameController.text;
  String get password => _passwordController.text;

  var _submitted = false;
  late var _formType = widget.formType;

  @override
  void dispose() {
    _node.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(namePasswordSignInControllerProvider.notifier);
      final success = await controller.submit(
        name: name,
        password: password,
        formType: _formType,
      );
      if (success) {
        widget.onSignedIn?.call();
      }
    }
  }

  void _nameEditingComplete() {
    if (canSubmitName(name)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitName(name)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType() {
    setState(() => _formType = _formType.secondaryActionFormType);
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      namePasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(namePasswordSignInControllerProvider);
    return ResponsiveScrollableCard(
      child: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              gapH8,
              TextFormField(
                key: NamePasswordSignInScreen.nameKey,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Имя пользователя',
                  enabled: !state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) =>
                    !_submitted ? null : nameErrorText(name ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _nameEditingComplete(),
                inputFormatters: <TextInputFormatter>[
                  ValidatorInputFormatter(
                      editingValidator: NameEditingRegexValidator()),
                ],
              ),
              gapH8,
              TextFormField(
                key: NamePasswordSignInScreen.passwordKey,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: _formType.passwordLabelText,
                  enabled: !state.isLoading,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => !_submitted
                    ? null
                    : passwordErrorText(password ?? '', _formType),
                obscureText: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _passwordEditingComplete(),
              ),
              gapH8,
              PrimaryButton(
                text: _formType.primaryButtonText,
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : () => _submit(),
              ),
              gapH8,
              CustomTextButton(
                text: _formType.secondaryButtonText,
                onPressed: state.isLoading ? null : _updateFormType,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
