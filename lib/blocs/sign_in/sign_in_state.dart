part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInFailure extends SignInState {
  final String? message;
  const SignInFailure({this.message});
}

class SignInSuccess extends SignInState {}

class SignInProcess extends SignInState {}
