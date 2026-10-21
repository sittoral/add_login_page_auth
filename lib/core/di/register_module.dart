import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  Talker get talker => Talker();
}
