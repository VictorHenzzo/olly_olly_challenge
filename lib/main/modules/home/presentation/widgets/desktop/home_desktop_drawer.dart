part of '../../home_screen.dart';

class _HomeDesktopDrawer extends StatelessWidget {
  const _HomeDesktopDrawer({
    required this.signOut,
  });

  final VoidCallback signOut;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return Container(
      decoration: BoxDecoration(
        color: uiContext.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (final context, final state) =>
                  _buildByState(uiContext, state),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: signOut,
            child: const Text('Sign Out'),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildByState(final UiContext uiContext, final HomeState state) {
    return switch (state) {
      HomeInitial() => _loading(uiContext),
      HomeLoading() => _loading(uiContext),
      (final HomeLoaded s) => _CurrentWeatherContent(state: s, isDesktop: true),
      _ => _error(uiContext),
    };
  }

  Widget _loading(final UiContext uiContext) {
    return ScreenLoading(
      color: uiContext.colorScheme.onPrimary,
    );
  }

  Widget _error(final UiContext uiContext) {
    final dimension = uiContext.shp(10);

    return Icon(
      Icons.error,
      color: uiContext.colorScheme.error,
      size: dimension,
    );
  }
}
