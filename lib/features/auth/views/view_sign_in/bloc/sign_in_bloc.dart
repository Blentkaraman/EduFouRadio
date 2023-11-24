import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class AuthBloc extends Bloc<AuthEvent, SignInState> {
  AuthBloc() : super(SignInInitial()) {
    on<SignUpEvent>(_signUpEvent);
    on<SignInEvent>(_signInEvent);
  }

  Future<FutureOr<void>> _signUpEvent(
      SignUpEvent event, Emitter<SignInState> emit) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
  }

  Future<FutureOr<void>> _signInEvent(
      SignInEvent event, Emitter<SignInState> emit) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
  }
}
