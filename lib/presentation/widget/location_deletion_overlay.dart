import 'package:flutter/material.dart';
import 'animated_deletion_overlay.dart';

class LocationDeletionOverlay extends StatelessWidget {
  final bool isDeleting;

  const LocationDeletionOverlay({Key? key, required this.isDeleting})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedDeletionOverlay(isDeleting: isDeleting);
  }
}
