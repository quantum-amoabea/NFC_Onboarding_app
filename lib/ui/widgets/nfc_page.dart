import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_rfid/ui/widgets/nfc_card.dart';
import 'package:nfc_rfid/ui/widgets/read_nfc.dart';
import 'package:nfc_rfid/utils/custom_text_field.dart';
import 'package:nfc_rfid/utils/custom_textbutton.dart';
import 'package:nfc_rfid/utils/toast_message.dart';

class NfcPage extends StatefulWidget {
  const NfcPage({super.key});

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  dynamic tagValue;
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final FocusNode vehicleFocusNode = FocusNode();
  final FocusNode cardFocusNode = FocusNode();

  Future<void> readTag() async {
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Lottie.asset('assets/nfc_scan.json', height: 300),
                const SizedBox(height: 10),
                const Text(
                  "Hold your phone near the NFC tag",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Place the card at the back of your phone",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      final tag = await readNFCTag();

      Navigator.pop(context);

      setState(() {
        tagValue = tag;
      });
    } catch (e) {
      Navigator.pop(context);
      debugPrint("Error reading NFC: $e");
    } finally {}
  }

  void clearAll() {
    setState(() {
      tagValue = null;
      vehicleNumberController.clear();
      cardNumberController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("NFC Reader"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                title: 'Enter Vehicle Number',
                hintText: 'Enter Vehicle Number',
                controller: vehicleNumberController,
                focusNode: vehicleFocusNode,
                nextFocusNode: cardFocusNode,
              ),
              CustomTextField(
                title: 'Enter Card Number',
                hintText: 'Enter Card Number',
                controller: cardNumberController,
                focusNode: cardFocusNode,
                onSubmitted: () async {
                  await readTag();
                },
              ),
              NfcTagCard(
                tag: tagValue,
                vehicleNumber: vehicleNumberController.text,
                cardNumber: cardNumberController.text,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextButton(
                      text: 'Read',
                      onPressed: () async {
                        if (vehicleNumberController.text.isEmpty &&
                            cardNumberController.text.isEmpty) {
                          showToast(message: 'Please Enter a Vehicle Number');
                        } else {
                          await readTag();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: CustomTextButton(
                      text: 'Save',
                      onPressed: () => clearAll(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
