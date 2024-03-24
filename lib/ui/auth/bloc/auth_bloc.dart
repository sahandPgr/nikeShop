import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_shop/data/repo/auth_repository.dart';
import 'package:nike_shop/utils/exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  bool isLogin;
  bool obscureText;
  AuthBloc(this.authRepository, {this.isLogin = true, this.obscureText = true})
      : super(AuthInitial(isLogin, obscureText)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonClicked) {
          emit(AuthLoading(isLogin, obscureText));
          if (isLogin) {
            await authRepository.login(event.username, event.password);
            emit(AuthSuccess(isLogin, obscureText));
          } else {
            await authRepository.register(event.username, event.password);
            emit(AuthSuccess(isLogin, obscureText));
          }
        } else if (event is AuthModeChangeIsClicked) {
          isLogin = !isLogin;
          emit(AuthInitial(isLogin, obscureText));
        } else if (event is AuthPasswordHideClicked) {
          obscureText = !obscureText;
          emit(AuthInitial(isLogin, obscureText));
        }
      } catch (e) {
        emit(AuthError(isLogin, AppException(), obscureText));
      }
    });
  }
}
