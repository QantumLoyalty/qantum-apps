import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UnitedTermsList extends StatelessWidget {
  const UnitedTermsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bulletText(
          context,
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              children: [
                const TextSpan(
                  text:
                  'By using this fuel discount barcode, you agree that you have read and accepted ',
                ),
                TextSpan(
                  text: "United's terms and conditions",
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {

                    },
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),

        _bulletText(
          context,
          const Text(
            'This barcode can only be used once a day, for up to 150 litres.',
            style: TextStyle(fontSize: 14),
          ),
        ),

        _bulletText(
          context,
          const Text(
            'A new barcode is generated daily at 12.01am AEST and is valid for 24 hours.',
            style: TextStyle(fontSize: 14),
          ),
        ),

        _bulletText(
          context,
          const Text(
            'This barcode cannot be used at United unmanned/self-serve locations or when paying via a United outdoor payment terminal.',
            style: TextStyle(fontSize: 14),
          ),
        ),

        _bulletText(
          context,
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              children: [
                const TextSpan(
                  text:
                  'For further assistance, please contact Customer Solutions at ',
                ),
                TextSpan(
                  text: '1300 383 587',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {

                    },
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _bulletText(BuildContext context, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•  ',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
