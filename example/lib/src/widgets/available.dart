part of widget;

class Available extends StatelessWidget {
  const Available({
    Key? key,
    this.onRead,
    this.onWrite,
  }) : super(key: key);

  final VoidCallback? onRead;
  final VoidCallback? onWrite;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onRead', onRead))
      ..add(ObjectFlagProperty<VoidCallback>.has('onWrite', onWrite));
  }

  @override
  Widget build(BuildContext context) =>
    GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      children: <Widget>[
        GridButtonWidget(
          onTap: onRead,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              "READ",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        GridButtonWidget(
          onTap: onWrite,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              "WRITE",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
}

class NotAvailable extends StatelessWidget {
  const NotAvailable({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "NFC features isn't available",
            style: Theme.of(context).textTheme.headline6,
          ),
          TextButton(
            style: TextButton.styleFrom(
              elevation: 2,
              primary: Colors.green,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.all(8),
            ),
            onPressed: FlutterNfc.instance.openSetting,
            child: Text(
              "Open NFC Setting",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
}