// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:magazine_models/core/di/register_module.dart' as _i439;
import 'package:magazine_models/core/service/secure_storage_service.dart'
    as _i680;
import 'package:magazine_models/features/auth/data/data_source/abstract/auth_data_source.dart'
    as _i1040;
import 'package:magazine_models/features/auth/data/data_source/remote/auth_data_source_impl.dart'
    as _i336;
import 'package:magazine_models/features/auth/data/repo_impl/auth_repo_impl.dart'
    as _i1039;
import 'package:magazine_models/features/auth/domain/repo/auth_repo.dart'
    as _i55;
import 'package:magazine_models/features/auth/ui/cubit/auth_cubit.dart'
    as _i456;
import 'package:magazine_models/features/news/data/datasources/news_remote_data_source.dart'
    as _i880;
import 'package:magazine_models/features/news/data/repositories/news_repository_impl.dart'
    as _i39;
import 'package:magazine_models/features/news/domain/repositories/news_repository.dart'
    as _i170;
import 'package:magazine_models/features/news/domain/usecases/search_news_usecase.dart'
    as _i74;
import 'package:magazine_models/features/news/ui/bloc/news_bloc.dart' as _i943;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
    gh.lazySingleton<_i993.Talker>(() => registerModule.talker);
    gh.lazySingleton<_i680.SecureStorageService>(
      () => _i680.SecureStorageService(),
    );
    gh.lazySingleton<_i1040.AuthDataSource>(
      () => _i336.AuthDataSourceImpl(
        talker: gh<_i993.Talker>(),
        secureStorageService: gh<_i680.SecureStorageService>(),
      ),
    );
    gh.lazySingleton<_i55.AuthRepo>(
      () => _i1039.AuthRepoImpl(gh<_i1040.AuthDataSource>()),
    );
    gh.lazySingleton<_i880.NewsRemoteDataSource>(
      () => _i880.NewsRemoteDataSource(gh<_i519.Client>()),
    );
    gh.factory<_i456.AuthCubit>(() => _i456.AuthCubit(gh<_i55.AuthRepo>()));
    gh.lazySingleton<_i170.NewsRepository>(
      () => _i39.NewsRepositoryImpl(gh<_i880.NewsRemoteDataSource>()),
    );
    gh.lazySingleton<_i74.SearchNewsUseCase>(
      () => _i74.SearchNewsUseCase(gh<_i170.NewsRepository>()),
    );
    gh.factory<_i943.NewsBloc>(
      () => _i943.NewsBloc(gh<_i74.SearchNewsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i439.RegisterModule {}
