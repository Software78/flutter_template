import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project_template/core/storage/shared_prefs_impl.dart';
import 'package:flutter_project_template/features/auth/repository/repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../core/navigation/navigator.dart';
import '../../core/security/crypto.dart';
import '../../core/storage/database_storage_client.dart';
import '../../core/storage/encrypted_storage_impl.dart';
import '../../core/storage/storage_client.dart';
import '../../core/utils/observers.dart';
import '../flavor/build_variables.dart';

 GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppInitializer {
  static late GetIt instanceLocator;
  
  AppInitializer._();

  void close() {
    instanceLocator.reset();
  }

 static Future<void> create() async {
    instanceLocator = GetIt.instance;
    Bloc.observer = AppBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await dotenv.load(fileName: '.env');
    await ScreenUtil.ensureScreenSize();
    await EasyLocalization.ensureInitialized();
    BuildVariables.init();
    initialize();
  }

 static void initialize() {
    initializeSecurity();
    initializeNavigator();
    initializeLocalDataSources();
    initializeRemoteDataSources();
    initBlocs();
  }

static  void initializeNavigator() {
    instanceLocator.registerLazySingleton<NavigationService>(
      () => GoRouterNavigatorImpl(navigatorKey),
    );
  }

 static void initializeSecurity() {
    instanceLocator.registerSingleton<CryptoSystem>(
      AESCryptoSystem(
        key: buildVariables.encKey,
        vector: buildVariables.encVector,
      ),
    );
  }

 static void initializeLocalDataSources() {
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

 static void initBlocs() {
    // instanceLocator.registerFactory<ExampleBloc>(() => ExampleBloc());
  }

 static void initRepos() {
    instanceLocator
        .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  }

 static void initializeRemoteDataSources() {}
}
