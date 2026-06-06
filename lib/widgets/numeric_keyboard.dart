import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final void Function(String value) onNumberPressed;
  final VoidCallback onBackspacePressed;
  final VoidCallback onValidatePressed;

  const NumericKeyboard({
    super.key,
    required this.onNumberPressed,
    required this.onBackspacePressed,
    required this.onValidatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        _buildRow(['4', '5', '6']),
        _buildRow(['7', '8', '9']),
        Row(
          children: [
            _buildSpecialButton(
              icon: Icons.backspace,
              onPressed: onBackspacePressed,
            ),
            _buildNumberButton('0'),
            _buildSpecialButton(
              icon: Icons.check,
              onPressed: onValidatePressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> numbers) {
    return Row(children: numbers.map(_buildNumberButton).toList());
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: 58,
          child: ElevatedButton(
            onPressed: () => onNumberPressed(number),
            child: Text(number, style: const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: 58,
          child: ElevatedButton(onPressed: onPressed, child: Icon(icon)),
        ),
      ),
    );
  }
}
