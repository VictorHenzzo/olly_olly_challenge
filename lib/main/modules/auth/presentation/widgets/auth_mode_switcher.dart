part of '../auth_screen.dart';

class _AuthModeSwitcher extends StatelessWidget {
  const _AuthModeSwitcher({
    required this.modeController,
    required this.onSignIn,
    required this.onSignUp,
  });

  final ValueNotifier<_CurrentMode> modeController;
  final Widget Function() onSignIn;
  final Widget Function() onSignUp;

  @override
  Widget build(final BuildContext context) {
    return ValueListenableBuilder<_CurrentMode>(
      valueListenable: modeController,
      builder: (final context, final mode, final child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (final child, final animation) =>
              FadeTransition(opacity: animation, child: child),
          child: mode == _CurrentMode.signIn
              ? KeyedSubtree(
                  key: const ValueKey('signIn'),
                  child: onSignIn(),
                )
              : KeyedSubtree(
                  key: const ValueKey('signUp'),
                  child: onSignUp(),
                ),
        );
      },
    );
  }
}
