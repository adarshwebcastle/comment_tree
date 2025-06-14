import './tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootCommentWidget extends StatelessWidget {
  final PreferredSizeWidget avatar;
  final Widget content;
  final bool hasReplies;

  const RootCommentWidget(this.avatar, this.content, {this.hasReplies = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RootPainter(avatar.preferredSize, context.watch<TreeThemeData>().lineColor,
          context.watch<TreeThemeData>().lineWidth, Directionality.of(context),
          hasReplies: hasReplies),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: content,
          )
        ],
      ),
    );
  }
}

class RootPainter extends CustomPainter {
  Size? avatar;
  late Paint _paint;
  Color? pathColor;
  double? strokeWidth;
  final TextDirection textDecoration;
  final bool hasReplies;

  RootPainter(this.avatar, this.pathColor, this.strokeWidth, this.textDecoration, {this.hasReplies = false}) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!hasReplies) return;

    if (textDecoration == TextDirection.rtl) canvas.translate(size.width, 0);
    double dx = avatar!.width / 2;
    if (textDecoration == TextDirection.rtl) dx *= -1;
    canvas.drawLine(
      Offset(dx, avatar!.height),
      Offset(dx, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
