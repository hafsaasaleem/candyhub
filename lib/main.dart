import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:candyhub/screens/forgot_password/forgot_password_view.dart';
import 'package:candyhub/screens/login/login_screen.dart';
import 'package:candyhub/screens/register/register_view.dart';
import 'package:candyhub/screens/verify_email/verify_email_screen.dart';
import 'package:candyhub/service/auth/bloc/auth_bloc.dart';
import 'package:candyhub/service/auth/bloc/auth_event.dart';
import 'package:candyhub/service/auth/bloc/auth_state.dart';
import 'package:candyhub/service/auth/firebase_auth_provider.dart';
import 'firebase_options.dart';
import 'helpers/loading/loading_screen.dart';
import 'models/shopping_cart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/screens.dart';
import 'utilities/candyhub_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(
    (ShoppingCartAdapter()),
  );
  await Hive.openBox<ShoppingCart>('shoppingcart');

  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 10));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  static Route route() {
    return CupertinoPageRoute(builder: (context) => const App());
  }

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: CandyHubTheme.standard,
      home: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const ProductScreen(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const ProductScreen();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
