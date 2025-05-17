part of '../../home_screen.dart';

class _HomeScreenMobile extends StatelessWidget {
  const _HomeScreenMobile({
    required this.fetchData,
    required this.signOut,
    required this.openAppSettings,
  });

  final VoidCallback fetchData;
  final VoidCallback signOut;
  final VoidCallback openAppSettings;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: uiContext.textTheme.titleLarge?.copyWith(
            color: uiContext.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: uiContext.colorScheme.primary,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (final _, final state) {
          return switch (state) {
            HomeInitial() => _loading(),
            HomeLoading() => _loading(),
            HomeLoaded() => _HomeMobileTabs(state: state),
            HomeLocationPermissionDenied() => _PermissionDeniedError(
                state: state,
                tryAgain: fetchData,
                openAppSettings: openAppSettings,
              ),
            HomeError() => _UnknownHomeError(tryAgain: fetchData),
          };
        },
      ),
    );
  }

  Widget _loading() {
    return const ScreenLoading();
  }
}
