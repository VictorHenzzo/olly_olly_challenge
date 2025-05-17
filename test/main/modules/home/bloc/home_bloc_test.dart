import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/fetch_position_exception.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/open_app_settings_exception.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/main/modules/home/bloc/home_bloc.dart';

import '../../../../fixtures/position_fixture.dart';
import '../../../../fixtures/weather/current_weather_fixture.dart';
import '../../../../fixtures/weather/forecast_report_fixture.dart';
import '../../../../mocks/infra/app_navigator_mock.dart';
import '../../../../mocks/use_cases/auth/mock_sign_out_use_case.dart';
import '../../../../mocks/use_cases/geolocation/mock_fetch_position_use_case.dart';
import '../../../../mocks/use_cases/geolocation/mock_open_app_settings_use_case.dart';
import '../../../../mocks/use_cases/weather/mock_fetch_current_weather_use_case.dart';
import '../../../../mocks/use_cases/weather/mock_fetch_forecast_report_use_case.dart';
import '../../../../test_helpers.dart';

void main() {
  late HomeBloc sut;
  late MockFetchPositionUseCase fetchPositionUseCase;
  late MockFetchCurrentWeatherUseCase fetchCurrentWeatherUseCase;
  late MockFetchForecastReportUseCase fetchForecastReportUseCase;
  late MockOpenAppSettingsUseCase mockOpenAppSettingsUseCase;
  late MockSignOutUseCase signOutUseCase;
  late MockAppNavigator navigator;

  setUpAll(TestHelpers.registerFallbackValues);

  setUp(() {
    fetchPositionUseCase = MockFetchPositionUseCase();
    fetchCurrentWeatherUseCase = MockFetchCurrentWeatherUseCase();
    fetchForecastReportUseCase = MockFetchForecastReportUseCase();
    mockOpenAppSettingsUseCase = MockOpenAppSettingsUseCase();
    signOutUseCase = MockSignOutUseCase();
    navigator = MockAppNavigator();
    sut = HomeBloc(
      fetchPositionUseCase: fetchPositionUseCase,
      fetchWeatherUseCase: fetchCurrentWeatherUseCase,
      fetchForecastUseCase: fetchForecastReportUseCase,
      openAppSettingsUseCase: mockOpenAppSettingsUseCase,
      signOutUseCase: signOutUseCase,
      navigator: navigator,
      isWeb: false,
    );
  });

  group('FetchDataHomeEvent', () {
    final position = PositionFixture.entity();
    final currentWeather = CurrentWeatherFixture.entity();
    final forecastReport = ForecastReportFixture.entity();

    blocTest<HomeBloc, HomeState>(
      'should emit states in order when fetch data succeeds',
      setUp: () {
        fetchPositionUseCase.stubFetchPosition(position);
        fetchCurrentWeatherUseCase.stubFetchCurrentWeather(currentWeather);
        fetchForecastReportUseCase.stubFetchForecastReport(forecastReport);
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
      expect: () => [
        const HomeLoading(),
        HomeLoaded(
          position: position,
          currentWeather: currentWeather,
          forecastReport: forecastReport,
        ),
      ],
      verify: (final bloc) {
        verifyInOrder([
          () => fetchPositionUseCase.call(),
          () => fetchCurrentWeatherUseCase.call(position),
          () => fetchForecastReportUseCase.call(position),
        ]);

        verifyNoMoreInteractions(fetchPositionUseCase);
        verifyNoMoreInteractions(fetchCurrentWeatherUseCase);
        verifyNoMoreInteractions(fetchForecastReportUseCase);
        verifyZeroInteractions(mockOpenAppSettingsUseCase);
        verifyZeroInteractions(signOutUseCase);
        verifyZeroInteractions(navigator);
      },
    );

    group('Position fetch errors', () {
      blocTest<HomeBloc, HomeState>(
        'should emit error state when position fetch fails with unknown error',
        setUp: () {
          fetchPositionUseCase.stubFetchPositionException(
            const UnknownFetchPositionException(),
          );
        },
        build: () => sut,
        act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
        expect: () => const [
          HomeLoading(),
          HomeError(),
        ],
        verify: (final bloc) {
          verifyZeroInteractions(fetchCurrentWeatherUseCase);
          verifyZeroInteractions(fetchForecastReportUseCase);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should emit location permission denied state when position fetch fails with denied error',
        setUp: () {
          fetchPositionUseCase.stubFetchPositionException(
            const DeniedFetchPositionException(),
          );
        },
        build: () => sut,
        act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
        expect: () => const [
          HomeLoading(),
          HomeLocationPermissionDenied(
            canOpenAppSettings: true,
            isPermanentlyDenied: false,
          ),
        ],
        verify: (final bloc) {
          verifyZeroInteractions(fetchCurrentWeatherUseCase);
          verifyZeroInteractions(fetchForecastReportUseCase);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should emit location permission denied state when position fetch fails with denied forever error',
        setUp: () {
          fetchPositionUseCase.stubFetchPositionException(
            const DeniedForeverFetchPositionException(),
          );
        },
        build: () => sut,
        act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
        expect: () => const [
          HomeLoading(),
          HomeLocationPermissionDenied(
            canOpenAppSettings: true,
            isPermanentlyDenied: true,
          ),
        ],
        verify: (final bloc) {
          verifyZeroInteractions(fetchCurrentWeatherUseCase);
          verifyZeroInteractions(fetchForecastReportUseCase);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'if is web, should emit location permission denied with `canOpenAppSettings` as false',
        setUp: () {
          sut = HomeBloc(
            fetchPositionUseCase: fetchPositionUseCase,
            fetchWeatherUseCase: fetchCurrentWeatherUseCase,
            fetchForecastUseCase: fetchForecastReportUseCase,
            openAppSettingsUseCase: mockOpenAppSettingsUseCase,
            signOutUseCase: signOutUseCase,
            navigator: navigator,
            isWeb: true,
          );

          fetchPositionUseCase.stubFetchPositionException(
            const DeniedForeverFetchPositionException(),
          );
        },
        build: () => sut,
        act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
        expect: () => const [
          HomeLoading(),
          HomeLocationPermissionDenied(
            canOpenAppSettings: false,
            isPermanentlyDenied: true,
          ),
        ],
      );
    });

    blocTest<HomeBloc, HomeState>(
      'should emit error state when weather fetch fails',
      setUp: () {
        fetchPositionUseCase.stubFetchPosition(position);
        fetchForecastReportUseCase.stubFetchForecastReport(forecastReport);
        fetchCurrentWeatherUseCase.stubFetchCurrentWeatherException(
          const AppException('error'),
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
      expect: () => const [
        HomeLoading(),
        HomeError(),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error state when forecast fetch fails',
      setUp: () {
        fetchPositionUseCase.stubFetchPosition(position);
        fetchCurrentWeatherUseCase.stubFetchCurrentWeather(currentWeather);
        fetchForecastReportUseCase.stubFetchForecastReportException(
          const AppException('error'),
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const FetchDataHomeEvent()),
      expect: () => const [
        HomeLoading(),
        HomeError(),
      ],
    );
  });

  group('SignOutHomeEvent', () {
    blocTest<HomeBloc, HomeState>(
      'should navigate to auth screen when sign out succeeds',
      setUp: () {
        signOutUseCase.stubSignOut();
        navigator.stubPushNamedAndRemoveAll();
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const SignOutHomeEvent()),
      expect: () => const <HomeState>[],
      verify: (final bloc) {
        verifyInOrder([
          () => signOutUseCase.call(),
          () => navigator.pushNamedAndRemoveAll<void>(AppDirections.authScreen),
        ]);

        verifyNoMoreInteractions(signOutUseCase);
        verifyNoMoreInteractions(navigator);
        verifyZeroInteractions(fetchPositionUseCase);
        verifyZeroInteractions(fetchCurrentWeatherUseCase);
        verifyZeroInteractions(fetchForecastReportUseCase);
        verifyZeroInteractions(mockOpenAppSettingsUseCase);
      },
    );
  });

  group('OpenAppSettingsHomeEvent', () {
    blocTest<HomeBloc, HomeState>(
      'should not emit any state when open app settings succeeds',
      setUp: () {
        mockOpenAppSettingsUseCase.stubOpenAppSettings();
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const OpenAppSettingsHomeEvent()),
      expect: () => const <HomeState>[],
      verify: (final bloc) {
        verify(() => mockOpenAppSettingsUseCase.call()).called(1);
        verifyNoMoreInteractions(mockOpenAppSettingsUseCase);
        verifyZeroInteractions(fetchPositionUseCase);
        verifyZeroInteractions(fetchCurrentWeatherUseCase);
        verifyZeroInteractions(fetchForecastReportUseCase);
        verifyZeroInteractions(signOutUseCase);
        verifyZeroInteractions(navigator);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error state when open app settings fails',
      setUp: () {
        mockOpenAppSettingsUseCase.stubOpenAppSettingsException(
          const UnknownOpenAppSettingsException(),
        );
      },
      build: () => sut,
      act: (final bloc) => bloc.add(const OpenAppSettingsHomeEvent()),
      expect: () => const [HomeError()],
      verify: (final bloc) {
        verify(() => mockOpenAppSettingsUseCase.call()).called(1);
        verifyNoMoreInteractions(mockOpenAppSettingsUseCase);
        verifyZeroInteractions(fetchPositionUseCase);
        verifyZeroInteractions(fetchCurrentWeatherUseCase);
        verifyZeroInteractions(fetchForecastReportUseCase);
        verifyZeroInteractions(signOutUseCase);
        verifyZeroInteractions(navigator);
      },
    );
  });
}
