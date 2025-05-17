part of '../../home_screen.dart';

class _ForecastReportDesktop extends StatelessWidget {
  const _ForecastReportDesktop({
    required this.fetchData,
    required this.openAppSettings,
  });

  final VoidCallback fetchData;
  final VoidCallback openAppSettings;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (final _, final state) {
        return switch (state) {
          HomeInitial() => _loading(),
          HomeLoading() => _loading(),
          HomeLoaded() => _ForecastContent(
              state: state,
              isDesktop: true,
            ),
          HomeLocationPermissionDenied() => _PermissionDeniedError(
              state: state,
              tryAgain: fetchData,
              openAppSettings: openAppSettings,
            ),
          HomeError() => _UnknownHomeError(tryAgain: fetchData),
        };
      },
    );
  }

  Widget _loading() {
    return const ScreenLoading();
  }
}
