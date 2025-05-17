part of '../../home_screen.dart';

class _HomeMobileTabs extends StatefulWidget {
  const _HomeMobileTabs({
    required this.state,
  });

  final HomeLoaded state;

  @override
  State<_HomeMobileTabs> createState() => _HomeMobileTabsState();
}

class _HomeMobileTabsState extends State<_HomeMobileTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);
    return Column(
      children: [
        ColoredBox(
          color: uiContext.colorScheme.primary,
          child: TabBar(
            controller: _tabController,
            indicatorColor: uiContext.colorScheme.onPrimary,
            labelColor: uiContext.colorScheme.onPrimary,
            unselectedLabelColor: uiContext.colorScheme.onPrimary.withValues(
              alpha: 0.6,
            ),
            tabs: const [
              Tab(text: 'Current Weather'),
              Tab(text: '5-Day Forecast'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _CurrentWeatherContent(
                state: widget.state,
                isDesktop: false,
              ),
              _ForecastContent(
                state: widget.state,
                isDesktop: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
