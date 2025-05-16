import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:olly_olly_challenge/core/infra/service_locator/get_it_service_locator.config.dart';
import 'package:olly_olly_challenge/core/infra/service_locator/service_locator.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void _configureDependencies(
  final GetIt getIt,
) =>
    $initGetIt(getIt);

class GetItServiceLocator implements ServiceLocator {
  const GetItServiceLocator();
  static final _getIt = GetIt.instance;

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  @override
  Future<void> initialize() async {
    _configureDependencies(_getIt);
  }
}
