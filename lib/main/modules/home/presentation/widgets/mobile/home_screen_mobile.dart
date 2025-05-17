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
    return const Placeholder();
  }
}
