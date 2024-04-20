import 'package:flutter/material.dart';

import '../../../../helpers/constants/constants.dart';
import '../../../../vaahextendflutter/app_theme.dart';

class LikeButton extends StatelessWidget {
  final bool? isCarLiked;
  final void Function()? onPressedToLike;
  final void Function()? onPressedToUnlike;
  const LikeButton(
      {super.key,
      this.onPressedToLike,
      this.isCarLiked,
      this.onPressedToUnlike});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isCarLiked ?? true == true ? Strings.unlike : Strings.like,
      icon: Icon(
          isCarLiked ?? true == true
              ? Icons.favorite
              : Icons.favorite_outline_rounded,
          color: isCarLiked ?? false == true
              ? AppTheme.colors['danger']
              : AppTheme.colors['black']),
      onPressed:
          isCarLiked ?? false == true ? onPressedToUnlike : onPressedToLike,
    );
  }
}
