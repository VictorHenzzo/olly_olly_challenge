part of '../../../home_screen.dart';

class _ForecastContent extends StatefulWidget {
  const _ForecastContent({
    required this.state,
    required this.isDesktop,
  });

  final HomeLoaded state;
  final bool isDesktop;

  @override
  State<_ForecastContent> createState() => _ForecastContentState();
}

class _ForecastContentState extends State<_ForecastContent> {
  int selectedIndex = 0;

  List<ForecastEntryEntity> get entries => widget.state.forecastReport.entries;
  ForecastEntryEntity get selected => entries[selectedIndex];

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return widget.isDesktop
        ? _buildDesktop(uiContext)
        : _buildMobile(uiContext);
  }

  Widget _buildDesktop(final UiContext uiContext) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 64, top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '5-Day Forecast',
            style: uiContext.textTheme.headlineLarge?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap a day to see details',
            style: uiContext.textTheme.bodyLarge?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Selected forecast entry',
            style: uiContext.textTheme.titleMedium?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          _SelectedForecastDetails(entry: selected, uiContext: uiContext),
          const SizedBox(height: 8),
          const Divider(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: entries.length,
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              itemBuilder: (final context, final index) {
                final entry = entries[index];
                return _ForecastListTile(
                  entry: entry,
                  selected: index == selectedIndex,
                  uiContext: uiContext,
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(final UiContext uiContext) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SelectedForecastDetails(entry: selected, uiContext: uiContext),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Tap a day to see details',
            style: uiContext.textTheme.bodyLarge?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: entries.length,
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              itemBuilder: (final context, final index) {
                final entry = entries[index];
                return _ForecastListTile(
                  entry: entry,
                  selected: index == selectedIndex,
                  uiContext: uiContext,
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
