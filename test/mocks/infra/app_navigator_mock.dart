import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/navigation/navigation/app_navigator.dart';

class MockAppNavigator extends Mock implements AppNavigator {
  void stubPushNamedAndRemoveAll() {
    when(
      () => pushNamedAndRemoveAll<void>(any()),
    ).thenAnswer((final _) => Future.value());
  }
}
