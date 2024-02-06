import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/core/storage/shared_prefs_impl.dart';
import 'package:flutter_project_template/features/auth/repository/repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../core/security/crypto.dart';
import '../../core/storage/database_storage_client.dart';
import '../../core/storage/encrypted_storage_impl.dart';
import '../../core/storage/storage_client.dart';
import '../../core/utils/observers.dart';
import '../flavor/build_variables.dart';

class AppInitializer {
  static late GetIt instanceLocator;

  AppInitializer._();

  void close() {
    instanceLocator.reset();
  }

  Future<void> create() async {
    instanceLocator = GetIt.instance;
    Bloc.observer = AppBlocObserver();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await ScreenUtil.ensureScreenSize();
    await EasyLocalization.ensureInitialized();
    BuildVariables.init();
    initialize();
  }

  void initialize() {
    initializeDataSources();
    initializeSecurity();
    initBlocs();
  }

  void initializeSecurity() {
    instanceLocator.registerSingleton<ICryptoSystem>(
      AESCryptoSystem(
        key: buildVariables.encKey,
        vector: buildVariables.encVector,
      ),
    );
  }

  void initializeDataSources() {
    instanceLocator.registerLazySingleton<StorageClient>(
      () => PrefsStorageImpl(),
    );
    instanceLocator.registerLazySingleton<EncryptedStorageClient>(
      () => SecureStorageClient(),
    );
    instanceLocator.registerLazySingleton<DatabaseStorage>(
      () => IsarStorageClient(
        directory: 'isar',
        schemas: [],
      ),
    );
  }

  void initBlocs() {
    // instanceLocator.registerFactory<ExampleBloc>(() => ExampleBloc());
  }

  void initRepos() {
    instanceLocator
        .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  }
}
