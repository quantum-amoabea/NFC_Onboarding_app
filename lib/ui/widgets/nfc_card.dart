import 'package:flutter/material.dart';

class NfcTagCard extends StatelessWidget {
  final dynamic tag;
  final String vehicleNumber;
  final String cardNumber;

  const NfcTagCard({
    super.key,
    required this.tag,
    required this.vehicleNumber,
    required this.cardNumber,
  });

  String displayValue(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return "  --";
    }
    return value.toString();
  }

  Widget buildRow(String title, dynamic value, {IconData? icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.red),

          if (icon != null) const SizedBox(width: 8),

          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              displayValue(value),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHighlightChip(String label, dynamic value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.yellow.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "$label: ${displayValue(value)}",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: const [
                Icon(Icons.nfc, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "NFC Tag Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: buildHighlightChip("Standard", tag?.standard),
          ),

          const Divider(height: 1),

          /// ⚪ DETAILS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                buildRow("ID", tag?.id, icon: Icons.fingerprint),
                buildRow(
                  "Vehicle Number",
                  vehicleNumber,
                  icon: Icons.car_crash_sharp,
                ),
                buildRow("Card Number", cardNumber, icon: Icons.card_giftcard),
                buildRow("ATQA", tag?.atqa, icon: Icons.memory),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
