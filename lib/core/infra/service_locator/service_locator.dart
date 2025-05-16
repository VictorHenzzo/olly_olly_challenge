import 'package:olly_olly_challenge/core/infra/service_locator/get_it_service_locator.dart';

abstract class ServiceLocator {
  factory ServiceLocator() => const GetItServiceLocator();
  // ignore: unused_element
  const ServiceLocator._();

  T get<T extends Object>();
  Future<void> initialize();
}
