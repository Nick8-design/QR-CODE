import 'package:flutter/material.dart';

import '../infrastructure/rate_prompt_controller.dart';

class RateAppAction extends StatelessWidget {
  const RateAppAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Rate and give feedback',
      onPressed: () => RatePromptController().openPlayStoreForRating(),
      icon: const Icon(Icons.star_rate_outlined),
    );
  }
}
