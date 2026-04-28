import 'package:flutter/cupertino.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

Future<dynamic> readNFCTag() async {
  try {
    NFCTag tag = await FlutterNfcKit.poll();
   /* debugPrint('the tag type is ${tag.type}');
    debugPrint('the tag id is ${tag.id}');
    debugPrint('the tag system code is ${tag.systemCode}');
    debugPrint('the tag application data is ${tag.applicationData}');
    debugPrint('the mifare type is ${tag.mifareInfo?.type}');
    debugPrint('the tag block size is ${tag.mifareInfo?.blockSize}');
    debugPrint('the tag systemCode is ${tag.systemCode}');
    debugPrint('the tag dsfId is ${tag.dsfId}');*/

    return tag;
  } catch (e) {
    debugPrint('Error reading NFC tag: $e');
  }
}
