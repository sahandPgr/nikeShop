part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState(this.isLogin, this.obscureText);

  final bool isLogin;
  final bool obscureText;

  @override
  List<Object> get props => [isLogin,obscureText];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.isLogin, super.obscureText);
}

class AuthLoading extends AuthState {
  const AuthLoading(super.isLogin, super.obscureText);
}

class AuthError extends AuthState {
  final AppException exception;

  @override
  List<Object> get props => [exception];
  const AuthError(super.isLogin, this.exception,super.obscureText);
}

class AuthSuccess extends AuthState {
  const AuthSuccess(super.isLogin, super.obscureText);
}
