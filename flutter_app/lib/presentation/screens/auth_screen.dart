import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.signup = false});
  final bool signup;
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController(),
      _email = TextEditingController(),
      _password = TextEditingController(),
      _confirm = TextEditingController();
  bool _hidden = true;
  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          final message = switch (state.error) {
            'invalid-credential' ||
            'wrong-password' ||
            'user-not-found' => l.invalidCredentials,
            'email-already-in-use' => l.emailInUse,
            'too-many-requests' => l.authThrottled,
            'network-request-failed' || 'networkError' => l.authNetworkError,
            'operation-not-allowed' => l.authNotEnabled,
            'user-disabled' => l.accountDisabled,
            _ => l.authError,
          };
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
        if (state.user != null && !state.loading) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.restaurant_rounded,
                      color: Color(0xFF00C27C),
                      size: 64,
                    ),
                    Text(
                      widget.signup ? l.signup : l.login,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    if (widget.signup)
                      TextFormField(
                        controller: _name,
                        decoration: InputDecoration(labelText: l.fullName),
                        validator: (value) =>
                            value == null ||
                                value.trim().isEmpty ||
                                (RegExp(r'^[a-z]').hasMatch(value.trim()))
                            ? l.nameError
                            : null,
                      ),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(labelText: l.email),
                      validator: (value) =>
                          RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                              .hasMatch(value?.trim() ?? '')
                          ? null
                          : l.emailError,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: _hidden,
                      decoration: InputDecoration(
                        labelText: l.password,
                        suffixIcon: IconButton(
                          tooltip: l.visibility,
                          onPressed: () => setState(() => _hidden = !_hidden),
                          icon: Icon(
                            _hidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) =>
                          (value?.length ?? 0) >= 6 ? null : l.passwordError,
                    ),
                    if (widget.signup)
                      TextFormField(
                        controller: _confirm,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: l.confirmPassword,
                        ),
                        validator: (value) =>
                            value == _password.text ? null : l.confirmError,
                      ),
                    const SizedBox(height: 24),
                    FilledButton(
                      key: const Key('submit-auth'),
                      onPressed: state.loading
                          ? null
                          : () {
                              if (!_form.currentState!.validate()) return;
                              final auth = context.read<AuthCubit>();
                              if (widget.signup) {
                                auth.signup(
                                  _name.text,
                                  _email.text,
                                  _password.text,
                                );
                              } else {
                                auth.login(_email.text, _password.text);
                              }
                            },
                      child: state.loading
                          ? const CircularProgressIndicator()
                          : Text(widget.signup ? l.signup : l.login),
                    ),
                    if (!widget.signup)
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AuthScreen(signup: true),
                          ),
                        ),
                        child: Text(l.signup),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
