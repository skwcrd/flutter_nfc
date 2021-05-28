part of view;

class ReadView extends StatefulWidget {
  const ReadView({ Key? key }) : super(key: key);

  @override
  _ReadViewState createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  final _text = StringBuffer();

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
          'Read NFC',
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
                        alertMessage: 'NFC read success!!')
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _text.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  void _onTag(NFCTag tag) {
    _text.clear();

    for ( final _tech in tag.techList ) {
      switch (_tech) {
        case NFCTagType.Ndef:
          final _ndef = tag.ndef!;
          debugPrint("NDEF: $_ndef");

          _text
            ..write("\n===== NDEF =====\n")
            ..write("isWritable: ${_ndef.isWritable}\n")
            ..write("maxSize: ${_ndef.maxSize}\n")
            ..write("cachedMessage: ${_ndef.cachedMessage}\n")
            ..write("additionalData: ${_ndef.additionalData}\n");
          break;

        case NFCTagType.NdefFormatable:
          final _ndefFormatable = tag.ndefFormatable!;
          debugPrint("NDEF Formatable: $_ndefFormatable");

          _text
            ..write("\n===== NDEF Formatable =====\n")
            ..write("identifier: ${_ndefFormatable.identifier.toHexString()}\n");
          break;

        case NFCTagType.NfcA:
          final _nfcA = tag.nfcA!;
          debugPrint("NFC (type A): $_nfcA");

          _text
            ..write("\n===== NFC (type A) =====\n")
            ..write("identifier: ${_nfcA.identifier.toHexString()}\n")
            ..write("atqa: ${_nfcA.atqa.toHexString()}\n")
            ..write("sak: ${_nfcA.sak}\n")
            ..write("maxTransceiveLength: ${_nfcA.maxTransceiveLength}\n")
            ..write("timeout: ${_nfcA.timeout}\n");
          break;

        case NFCTagType.NfcB:
          final _nfcB = tag.nfcB!;
          debugPrint("NFC (type B): $_nfcB");

          _text
            ..write("\n===== NFC (type B) =====\n")
            ..write("identifier: ${_nfcB.identifier.toHexString()}\n")
            ..write("applicationData: ${_nfcB.applicationData.toHexString()}\n")
            ..write("protocolInfo: ${_nfcB.protocolInfo.toHexString()}\n")
            ..write("maxTransceiveLength: ${_nfcB.maxTransceiveLength}\n");
          break;

        case NFCTagType.NfcF:
          final _nfcF = tag.nfcF!;
          debugPrint("NFC (type F): $_nfcF");

          _text
            ..write("\n===== NFC (type F) =====\n")
            ..write("identifier: ${_nfcF.identifier.toHexString()}\n")
            ..write("manufacturer: ${_nfcF.manufacturer.toHexString()}\n")
            ..write("systemCode: ${_nfcF.systemCode.toHexString()}\n")
            ..write("maxTransceiveLength: ${_nfcF.maxTransceiveLength}\n")
            ..write("timeout: ${_nfcF.timeout}\n");
          break;

        case NFCTagType.NfcV:
          final _nfcV = tag.nfcV!;
          debugPrint("NFC (type V): $_nfcV");

          _text
            ..write("\n===== NFC (type V) =====\n")
            ..write("identifier: ${_nfcV.identifier.toHexString()}\n")
            ..write("dsfId: ${_nfcV.dsfId}\n")
            ..write("responseFlags: ${_nfcV.responseFlags}\n")
            ..write("maxTransceiveLength: ${_nfcV.maxTransceiveLength}\n");
          break;

        case NFCTagType.IsoDep:
          final _isoDep = tag.isoDep!;
          debugPrint("IsoDep: $_isoDep");

          _text
            ..write("\n===== IsoDep =====\n")
            ..write("identifier: ${_isoDep.identifier.toHexString()}\n")
            ..write("hiLayerResponse: ${_isoDep.hiLayerResponse.toHexString()}\n")
            ..write("historicalBytes: ${_isoDep.historicalBytes.toHexString()}\n")
            ..write("isExtendedLengthApduSupported: ${_isoDep.isExtendedLengthApduSupported}\n")
            ..write("maxTransceiveLength: ${_isoDep.maxTransceiveLength}\n")
            ..write("timeout: ${_isoDep.timeout}\n");
          break;

        case NFCTagType.Mifare:
          final _mifare = tag.mifare!;
          debugPrint("MiFare: $_mifare");

          _text
            ..write("\n===== MiFare =====\n")
            ..write("identifier: ${_mifare.identifier.toHexString()}\n")
            ..write("mifareFamily: ${_mifare.mifareFamily}\n")
            ..write("historicalBytes: ${_mifare.historicalBytes.toHexString()}\n");
          break;

        case NFCTagType.MifareClassic:
          final _mifareClassic = tag.mifareClassic!;
          debugPrint("Mifare Classic: $_mifareClassic");

          _text
            ..write("\n===== Mifare Classic =====\n")
            ..write("identifier: ${_mifareClassic.identifier.toHexString()}\n")
            ..write("type: ${_mifareClassic.type}\n")
            ..write("blockCount: ${_mifareClassic.blockCount}\n")
            ..write("sectorCount: ${_mifareClassic.sectorCount}\n")
            ..write("size: ${_mifareClassic.size}\n")
            ..write("maxTransceiveLength: ${_mifareClassic.maxTransceiveLength}\n")
            ..write("timeout: ${_mifareClassic.timeout}\n");
          break;

        case NFCTagType.MifareUltralight:
          final _mifareUltralight = tag.mifareUltralight!;
          debugPrint("Mifare Ultralight: $_mifareUltralight");

          _text
            ..write("\n===== Mifare Ultralight =====\n")
            ..write("identifier: ${_mifareUltralight.identifier.toHexString()}\n")
            ..write("type: ${_mifareUltralight.type}\n")
            ..write("maxTransceiveLength: ${_mifareUltralight.maxTransceiveLength}\n")
            ..write("timeout: ${_mifareUltralight.timeout}\n");
          break;

        case NFCTagType.Felica:
          final _felica = tag.felica!;
          debugPrint("FeliCa: $_felica");

          _text
            ..write("\n===== FeliCa =====\n")
            ..write("currentSystemCode: ${_felica.currentSystemCode.toHexString()}\n")
            ..write("currentIDm: ${_felica.currentIDm.toHexString()}\n");
          break;

        case NFCTagType.Iso7816:
          final _iso7816 = tag.iso7816!;
          debugPrint("ISO7816: $_iso7816");

          _text
            ..write("\n===== ISO7816 =====\n")
            ..write("identifier: ${_iso7816.identifier.toHexString()}\n")
            ..write("initialSelectedAID: ${_iso7816.initialSelectedAID}\n")
            ..write("historicalBytes: ${_iso7816.historicalBytes.toHexString()}\n")
            ..write("applicationData: ${_iso7816.applicationData.toHexString()}\n")
            ..write("proprietaryApplicationDataCoding: ${_iso7816.proprietaryApplicationDataCoding}\n");
          break;

        case NFCTagType.Iso15693:
          final _iso15693 = tag.iso15693!;
          debugPrint("ISO15693: $_iso15693");

          _text
            ..write("\n===== ISO15693 =====\n")
            ..write("identifier: ${_iso15693.identifier.toHexString()}\n")
            ..write("icManufacturerCode: ${_iso15693.icManufacturerCode}\n")
            ..write("icSerialNumber: ${_iso15693.icSerialNumber.toHexString()}\n");
          break;

        default:
          debugPrint("unknown");
          _text.write(
            "\n===== unknown =====\n");
      }
    }

    if ( Platform.isIOS ) {
      tag
        .disposeTag()
        .then((_) => FlutterNfc.instance
          .stopSession(
            alertMessage: 'NFC read success!!')
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