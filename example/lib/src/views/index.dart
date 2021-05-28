part of view;

class IndexView extends StatefulWidget {
  const IndexView({ Key? key }) : super(key: key);

  @override
  _IndexViewState createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> implements WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAccessibilityFeatures() {
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {});
        break;

      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.inactive:
        break;

      case AppLifecycleState.detached:
        break;

      default:
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
  }

  @override
  void didChangeMetrics() {
  }

  @override
  void didChangePlatformBrightness() {
  }

  @override
  void didChangeTextScaleFactor() {
  }

  @override
  void didHaveMemoryPressure() {
  }

  @override
  Future<bool> didPopRoute() => Future<bool>.value(false);

  @override
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) =>
      didPushRoute(routeInformation.location!);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: const Text(
          'NFC Example',
        ),
      ),
      body: FutureBuilder<bool>(
        future: FlutterNfc.instance.isAvailable(),
        builder: (context, snapshot) {
          if ( snapshot.connectionState == ConnectionState.done ) {
            if ( snapshot.data! ) {
              return Available(
                onRead: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ReadView())),
                onWrite: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const WriteView())),
              );
            } else {
              return const NotAvailable();
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
}