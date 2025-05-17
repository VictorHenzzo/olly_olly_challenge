import 'package:weather_app/core/infra/service_locator/get_it_service_locator.dart';

/// A service locator that provides dependency injection capabilities.
/// This abstract class defines the interface for accessing and managing
/// application dependencies throughout the app lifecycle.
abstract class ServiceLocator {
  factory ServiceLocator() => const GetItServiceLocator();
  // ignore: unused_element
  const ServiceLocator._();

  /// Retrieves a dependency of type [T] from the service locator.
  /// Throws an exception if the dependency is not registered.
  T get<T extends Object>();

  /// Initializes the service locator and registers all dependencies.
  /// This method should be called before using any dependencies.
  Future<void> initialize();
}
