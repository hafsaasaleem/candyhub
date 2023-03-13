import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candyhub/extensions/buildcontext/loc.dart';
import 'package:candyhub/utilities/utilities.dart';
import '../../service/auth/auth_exceptions.dart';
import '../../service/auth/bloc/auth_bloc.dart';
import '../../service/auth/bloc/auth_event.dart';
import '../../service/auth/bloc/auth_state.dart';
import '../../utilities/dialogs/error_dialog.dart';

class LoginScreen extends StatelessWidget {
  static Route<LoginScreen> route() {
    return CupertinoPageRoute(
      builder: (context) => const LoginScreen(),
    );
  }

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_cannot_find_user,
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_wrong_credentials,
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_auth_error,
            );
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailTextEditingController;
  late final TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Login",
          style: CandyHubTextStyle.heading1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _emailTextEditingController,
          decoration: const InputDecoration(
            hintText: "Enter Email",
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordTextEditingController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "Enter Password",
            suffixIcon: Icon(CupertinoIcons.eye_slash_fill),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            final email = _emailTextEditingController.text;
            final password = _passwordTextEditingController.text;
            context.read<AuthBloc>().add(
                  AuthEventLogIn(
                    email,
                    password,
                  ),
                );
          },
          child: const Text("Login"),
        ),
        const SizedBox(height: 24),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.arrow_counterclockwise,
              color: CandyHubColors.purple,
              size: 36,
            ))
      ],
    );
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
