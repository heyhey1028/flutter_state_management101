import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    @required this.navigateTo,
    @required this.title,
  });

  final Widget navigateTo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: 180,
        child: ElevatedButton(
          onPressed: () => _navigateTo(context, navigateTo),
          child: Text(title),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget to) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => to),
    );
  }
}
