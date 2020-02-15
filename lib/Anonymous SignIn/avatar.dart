import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String photoUrl;
  final double radius;
  final double borderWidth;
  final Color borderClr;
  final VoidCallback onPressed;

  const Avatar(
      {@required this.photoUrl,
      @required this.radius,
      this.borderWidth,
      this.borderClr,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration(),
      child: InkWell(
        onTap: onPressed,
        child: new CircleAvatar(
          radius: radius,
          backgroundImage: photoUrl == null ? null : NetworkImage(photoUrl),
          child: photoUrl == null ? Icon(Icons.camera_alt) : null,
        ),
      ),
    );
  }

  Decoration _decoration() {
    if (borderWidth != null && borderClr != null) {
      return BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: borderWidth, color: borderClr));
    }
  }
}
