import 'package:flutter/material.dart';

class NotificationUtils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isError = false,
    IconData? icon,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    Future.delayed(Duration.zero, () {
      if (!context.mounted)
        return; // 🔥 Evita errores si el contexto ya no es válido

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        content: Row(
          children: [
            Icon(
              icon ?? (isError ? Icons.error_outline : Icons.info_outline),
              color: isError ? Colors.red[300] : Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
        backgroundColor:
            isError ? Colors.red[900] : Theme.of(context).colorScheme.secondary,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(8),
        action:
            actionLabel != null && onAction != null
                ? SnackBarAction(
                  label: actionLabel,
                  textColor: Colors.white,
                  onPressed: onAction,
                )
                : null,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static void showNoInternetNotification(BuildContext context) {
    showSnackBar(
      context: context,
      message:
          'No hay conexión a internet. Verifica tu conexión e intenta nuevamente.',
      isError: true,
      icon: Icons.wifi_off,
      actionLabel: 'Reintentar',
      onAction: () {
        // Esta acción puede ser personalizada según necesidades
      },
    );
  }
}
