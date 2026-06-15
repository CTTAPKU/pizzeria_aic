import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzeria_aic/features/auth/domain/entities/user.dart';
import 'package:pizzeria_aic/features/auth/domain/usecases/usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStateChangesUseCase _getAuthStateChangesUseCase;
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignOutUseCase _signOutUseCase;
  
  StreamSubscription<User?>? _authSubscription;

  AuthBloc({
    required GetAuthStateChangesUseCase getAuthStateChangesUseCase,
    required SignInWithEmailUseCase signInWithEmailUseCase,
    required SignUpWithEmailUseCase signUpWithEmailUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _getAuthStateChangesUseCase = getAuthStateChangesUseCase,
        _signInWithEmailUseCase = signInWithEmailUseCase,
        _signUpWithEmailUseCase = signUpWithEmailUseCase,
        _signOutUseCase = signOutUseCase,
        super(AuthInitial()) {
        
    on<WatchAuthStatus>(_onWatchAuthStatus);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  void _onWatchAuthStatus(WatchAuthStatus event, Emitter<AuthState> emit) {
    _authSubscription?.cancel();
    _authSubscription = _getAuthStateChangesUseCase().listen((user) {
      add(AuthUserChanged(user));
    });
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    final user = event.user;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _signInWithEmailUseCase(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(_cleanErrorMessage(e.toString())));
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _signUpWithEmailUseCase(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(_cleanErrorMessage(e.toString())));
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _signOutUseCase();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(_cleanErrorMessage(e.toString())));
    }
  }

  String _cleanErrorMessage(String rawMessage) {
    if (rawMessage.contains('] ')) {
      return rawMessage.split('] ').last;
    }
    return rawMessage;
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
