part of view;

class WriteView extends StatefulWidget {
  const WriteView({ Key? key }) : super(key: key);

  @override
  _WriteViewState createState() => _WriteViewState();
}

class _WriteViewState extends State<WriteView> {
  late bool _isOpenSession;

  @override
  void initState() {
    super.initState();
    _isOpenSession = false;
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: const Text(
          'Write NFC',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Please open NFC session before tap the NFC tag",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 2,
                  primary: _isOpenSession ? Colors.red : Colors.green,
                  backgroundColor: _isOpenSession ? Colors.red : Colors.green,
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: _isOpenSession
                  ? () => FlutterNfc.instance
                      .stopSession(
                        alertMessage: 'NFC write success!!')
                      .then((_) => setState(() {
                        _isOpenSession = false;
                      }))
                  : () => FlutterNfc.instance
                      .startSession(
                        onTagDiscovered: _onTag,
                        alertMessage: 'Please tap the NFC tag',
                        onError: (error) => FlutterNfc.instance
                          .stopSession(
                            errorMessage: error.message ?? error.toString())
                          .then((_) => setState(() {
                            _isOpenSession = false;
                          })))
                      .then((_) => setState(() {
                        _isOpenSession = true;
                      })),
                child: Text(
                  _isOpenSession ? "Close NFC Session" : "Open NFC Session",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  void _onTag(NFCTag tag) {
    // for ( final _tech in tag.techList ) {
    //   switch (_tech) {
    //     case NFCTagType.Ndef:
    //       final _ndef = tag.ndef!;
    //       break;

    //     case NFCTagType.NdefFormatable:
    //       final _ndefFormatable = tag.ndefFormatable!;
    //       break;

    //     case NFCTagType.NfcA:
    //       final _nfcA = tag.nfcA!;
    //       break;

    //     case NFCTagType.NfcB:
    //       final _nfcB = tag.nfcB!;
    //       break;

    //     case NFCTagType.NfcF:
    //       final _nfcF = tag.nfcF!;
    //       break;

    //     case NFCTagType.NfcV:
    //       final _nfcV = tag.nfcV!;
    //       break;

    //     case NFCTagType.IsoDep:
    //       final _isoDep = tag.isoDep!;
    //       break;

    //     case NFCTagType.Mifare:
    //       final _mifare = tag.mifare!;
    //       break;

    //     case NFCTagType.MifareClassic:
    //       final _mifareClassic = tag.mifareClassic!;
    //       break;

    //     case NFCTagType.MifareUltralight:
    //       final _mifareUltralight = tag.mifareUltralight!;
    //       break;

    //     case NFCTagType.Felica:
    //       final _felica = tag.felica!;
    //       break;

    //     case NFCTagType.Iso7816:
    //       final _iso7816 = tag.iso7816!;
    //       break;

    //     case NFCTagType.Iso15693:
    //       final _iso15693 = tag.iso15693!;
    //       break;

    //     default:
    //   }
    // }

    if ( Platform.isIOS ) {
      tag
        .disposeTag()
        .then((_) => FlutterNfc.instance
          .stopSession(
            alertMessage: 'NFC write success!!')
          .then((_) => setState(() {
            _isOpenSession = false;
          })));
    } else {
      tag
        .disposeTag()
        .then((_) => setState(() {}));
    }
  }
}