import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzeria_aic/features/auth/data/datasources/remote_datasource.dart';
import 'package:pizzeria_aic/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pizzeria_aic/features/auth/domain/usecases/usecases.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_event.dart';
import 'package:pizzeria_aic/features/auth/presentation/bloc/auth_state.dart';
import 'package:pizzeria_aic/features/auth/presentation/sign_in.dart';
import 'package:pizzeria_aic/core/theme/theme.dart';
import 'package:pizzeria_aic/core/widgets/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final remoteDataSource = AuthRemoteDataSource();
  final authRepository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

  final getAuthStateChangesUseCase = GetAuthStateChangesUseCase(authRepository);
  final signInWithEmailUseCase = SignInWithEmailUseCase(authRepository);
  final signUpWithEmailUseCase = SignUpWithEmailUseCase(authRepository);
  final signOutUseCase = SignOutUseCase(authRepository);

  final authBloc = AuthBloc(
    getAuthStateChangesUseCase: getAuthStateChangesUseCase,
    signInWithEmailUseCase: signInWithEmailUseCase,
    signUpWithEmailUseCase: signUpWithEmailUseCase,
    signOutUseCase: signOutUseCase,
  )..add(WatchAuthStatus());

  runApp(MyApp(authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  const MyApp({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const NavBar();
            }
            if (state is AuthInitial) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SignIn();
          },
        ),
        theme: CustomThemeData.getAppTheme(),
      ),
    );
  }
}
