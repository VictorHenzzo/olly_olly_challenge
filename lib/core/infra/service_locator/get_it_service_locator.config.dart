// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/auth_data_source/auth_data_source.dart'
    as _i563;
import '../../data/data_sources/auth_data_source/auth_data_source_module.dart'
    as _i117;
import '../../data/data_sources/geolocation_data_source/geolocation_data_source.dart'
    as _i382;
import '../../data/data_sources/geolocation_data_source/geolocator_data_source_impl.dart'
    as _i11;
import '../../data/data_sources/http/http_data_source.dart' as _i808;
import '../../data/data_sources/http/http_service_locator_module.dart' as _i126;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/geolocation_repository.dart' as _i351;
import '../../data/repositories/weather_repository_impl.dart' as _i312;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/geolocation_repository.dart' as _i562;
import '../../domain/repositories/weather_repository.dart' as _i650;
import '../../domain/use_cases/auth/fetch_auth_status_use_case.dart' as _i726;
import '../../domain/use_cases/auth/sign_in_use_case.dart' as _i542;
import '../../domain/use_cases/auth/sign_out_use_case.dart' as _i204;
import '../../domain/use_cases/auth/sign_up_use_case.dart' as _i251;
import '../../domain/use_cases/geolocation/fetch_position_use_case.dart'
    as _i419;
import '../../domain/use_cases/geolocation/open_app_settings_use_case.dart'
    as _i1065;
import '../../domain/use_cases/weather/fetch_current_weather_use_case.dart'
    as _i127;
import '../../domain/use_cases/weather/fetch_forecast_report_use_case.dart'
    as _i135;
import '../../navigation/navigation/app_navigator.dart' as _i364;
import '../env/environment.dart' as _i579;
import '../logger/debug_logger.dart' as _i197;
import '../logger/logger.dart' as _i512;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final authDataSourceModule = _$AuthDataSourceModule();
  final httpServiceLocatorModule = _$HttpServiceLocatorModule();
  gh.factory<_i579.Environment>(() => const _i579.Environment());
  gh.factory<_i364.AppNavigator>(() => const _i364.AppNavigator());
  gh.lazySingleton<_i59.FirebaseAuth>(() => authDataSourceModule.firebaseAuth);
  gh.lazySingleton<_i519.Client>(() => httpServiceLocatorModule.httpClient);
  gh.factory<_i512.Logger>(() => _i197.DebugLogger());
  gh.lazySingleton<_i563.AuthDataSource>(
      () => authDataSourceModule.authDataSource(gh<_i59.FirebaseAuth>()));
  gh.lazySingleton<_i808.HttpDataSource>(
      () => httpServiceLocatorModule.httpDataSource(
            gh<_i519.Client>(),
            gh<_i512.Logger>(),
          ));
  gh.factory<_i1073.AuthRepository>(
      () => _i895.AuthRepositoryImpl(gh<_i563.AuthDataSource>()));
  gh.factory<_i650.WeatherRepository>(() => _i312.WeatherRepositoryImpl(
        httpDataSource: gh<_i808.HttpDataSource>(),
        environment: gh<_i579.Environment>(),
      ));
  gh.factory<_i542.SignInUseCase>(
      () => _i542.SignInUseCaseImpl(gh<_i1073.AuthRepository>()));
  gh.factory<_i726.FetchAuthStatusUseCase>(
      () => _i726.FetchAuthStatusUseCaseImpl(gh<_i1073.AuthRepository>()));
  gh.factory<_i251.SignUpUseCase>(
      () => _i251.SignUpUseCaseImpl(gh<_i1073.AuthRepository>()));
  gh.factory<_i204.SignOutUseCase>(
      () => _i204.SignOutUseCaseImpl(gh<_i1073.AuthRepository>()));
  gh.factoryParam<_i382.GeolocationDataSource, _i11.GeolocatorAdapter?,
      dynamic>((
    geolocatorAdapter,
    _,
  ) =>
      _i11.GeolocatorDataSourceImpl(geolocatorAdapter: geolocatorAdapter));
  gh.factory<_i127.FetchCurrentWeatherUseCase>(() =>
      _i127.FetchCurrentWeatherUseCaseImpl(gh<_i650.WeatherRepository>()));
  gh.factory<_i135.FetchForecastReportUseCase>(() =>
      _i135.FetchForecastReportUseCaseImpl(gh<_i650.WeatherRepository>()));
  gh.factory<_i562.GeolocationRepository>(
      () => _i351.GeolocationRepositoryImpl(gh<_i382.GeolocationDataSource>()));
  gh.factory<_i1065.OpenAppSettingsUseCase>(
      () => _i1065.OpenAppSettingsUseCaseImpl(
            gh<_i562.GeolocationRepository>(),
            isWeb: gh<bool>(),
          ));
  gh.factory<_i419.FetchPositionUseCase>(
      () => _i419.FetchPositionUseCaseImpl(gh<_i562.GeolocationRepository>()));
  return getIt;
}

class _$AuthDataSourceModule extends _i117.AuthDataSourceModule {}

class _$HttpServiceLocatorModule extends _i126.HttpServiceLocatorModule {}
