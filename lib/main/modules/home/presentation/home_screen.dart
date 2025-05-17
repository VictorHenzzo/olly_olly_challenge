import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/domain/entities/weather/forecast_entry_entity.dart';
import 'package:weather_app/main/extensions/date_time_extension.dart';
import 'package:weather_app/main/modules/home/bloc/home_bloc.dart';
import 'package:weather_app/main/shared/ui_context.dart';
import 'package:weather_app/main/shared/widgets/adaptative_widget.dart';
import 'package:weather_app/main/shared/widgets/screen_loading.dart';
import 'package:weather_app/main/shared/widgets/weather_icon_viewer.dart';

part 'widgets/desktop/home_screen_desktop.dart';
part 'widgets/mobile/home_screen_mobile.dart';
part 'widgets/errors/permission_denied_error.dart';
part 'widgets/errors/unknown_home_error.dart';
part 'widgets/desktop/home_desktop_drawer.dart';
part 'widgets/weather/current_weather_content.dart';
part 'widgets/desktop/forecast_report_desktop.dart';
part 'widgets/mobile/home_mobile_tabs.dart';
part 'widgets/weather/forecast_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.bloc, super.key});

  final HomeBloc bloc;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return AdaptativeWidgetBuilder(
      mobile: (final _, final __) => _HomeScreenMobile(
        fetchData: _fetchData,
        signOut: _signOut,
        openAppSettings: _openAppSettings,
      ),
      desktop: (final _, final __) => _HomeScreenDesktop(
        fetchData: _fetchData,
        signOut: _signOut,
        openAppSettings: _openAppSettings,
      ),
    );
  }

  void _fetchData() {
    widget.bloc.add(const FetchDataHomeEvent());
  }

  void _signOut() {
    widget.bloc.add(const SignOutHomeEvent());
  }

  void _openAppSettings() {
    widget.bloc.add(const OpenAppSettingsHomeEvent());
  }
}
