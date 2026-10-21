import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/auth_repo.dart';

sealed class AuthState {}

class AuthIdle extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo;
  AuthCubit(this._repo) : super(AuthIdle());

  Future<void> login(String login, String password) async {
    if (login.trim().isEmpty || password.isEmpty) {
      emit(AuthError('Введите логин и пароль'));
      return;
    }
    emit(AuthLoading());
    try {
      final ok = await _repo.login(login.trim(), password);
      emit(ok ? AuthSuccess() : AuthError('Неверный логин или пароль'));
    } catch (e) {
      emit(AuthError('Ошибка соединения: $e'));
    }
  }
}
