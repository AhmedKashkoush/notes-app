import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;
  final Color outlineColor;
  const LikeButton({
    Key? key,
    required this.isLiked,
    required this.onTap,
    required this.outlineColor,
  }) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;
  @override
  void initState() {
    _isLiked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLiked = !_isLiked;
          widget.onTap.call();
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        switchInCurve: Curves.bounceInOut,
        switchOutCurve: Curves.bounceInOut,
        child: _isLiked
            ? Icon(
                Ionicons.heart,
                key: ValueKey<bool>(_isLiked),
                color: Colors.red,
              )
            : Icon(
                Ionicons.heart_outline,
                key: ValueKey<bool>(_isLiked),
                color: widget.outlineColor,
              ),
      ),
    );
  }
}
