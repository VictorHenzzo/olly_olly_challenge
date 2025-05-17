part of '../../home_screen.dart';

class _HomeScreenDesktop extends StatelessWidget {
  const _HomeScreenDesktop({
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
      body: Row(
        children: [
          SizedBox(
            width: uiContext.swp(25),
            child: _HomeDesktopDrawer(signOut: signOut),
          ),
          Expanded(
            child: _ForecastReportDesktop(
              fetchData: fetchData,
              openAppSettings: openAppSettings,
            ),
          ),
        ],
      ),
    );
  }
}
