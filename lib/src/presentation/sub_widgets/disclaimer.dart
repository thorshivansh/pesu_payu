import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Disclaimer :",
            // style: Properties.textsStyles.text15_500,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.checkCircle,
              color: Colors.green,
              size: 14,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Successful-Demand/Partial Amount has been made successful and verified by finance department.",
                maxLines: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: 8), // Add spacing between rows
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.clock,
              color: Colors.grey,
              size: 16,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Paid-Demand/Partial Amount has been made successful and To be verified by finance department.",
                maxLines: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: 8), // Add spacing between rows
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.xCircle,
              color: Color.fromRGBO(244, 67, 54, 1),
              size: 14,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Rejected-Transaction Details not matched with bank records.",
                maxLines: 3,
              ),
            ),
          ],
        )
      ],
    );
  }
}
