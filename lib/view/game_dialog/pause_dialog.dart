import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class PauseDialog extends StatelessWidget {
  static Future show(BuildContext context, {required VoidCallback onQuit}) {
    return showDialog(
      context: context,
      builder: (_) => PauseDialog(onQuit: onQuit),
    );
  }

  const PauseDialog({super.key, required this.onQuit});

  final VoidCallback onQuit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).pausedDialogTitle,
      ),
      content: Text(
        AppLocalizations.of(context).pausedDialogContent,
      ),
      actions: [
        TextButton(
          onPressed: onQuit,
          child: Text(AppLocalizations.of(context).quit),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).resume),
        ),
      ],
    );
  }
}
