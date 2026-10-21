import 'package:injectable/injectable.dart';
import '../../domain/repo/auth_repo.dart';
import '../data_source/abstract/auth_data_source.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _dataSource;
  AuthRepoImpl(this._dataSource);

  @override
  Future<bool> login(String login, String password) =>
      _dataSource.auth(login, password);
}
