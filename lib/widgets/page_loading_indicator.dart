import 'package:flutter/material.dart';

import 'content_card.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ContentCard(
      margin: EdgeInsets.only(
        left: 0.5,
        right: 0.5,
        top: 0,
        bottom: 0,
      ),
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
