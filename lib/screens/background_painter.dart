import 'package:flutter/cupertino.dart';

import '../constants.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8090733, size.height * 0.8766571);
    path_0.cubicTo(
        size.width * 1.033314,
        size.height * 1.141068,
        size.width * 1.350427,
        size.height * 0.9056357,
        size.width * 1.406764,
        size.height * 0.8140643);
    path_0.lineTo(size.width * 0.7443560, size.height * -0.8892857);
    path_0.lineTo(size.width * -0.4841309, size.height * 0.01421550);
    path_0.cubicTo(
        size.width * -0.4844817,
        size.height * 0.04637964,
        size.width * -0.4619843,
        size.height * 0.1505268,
        size.width * -0.3691806,
        size.height * 0.3098032);
    path_0.cubicTo(
        size.width * -0.2531764,
        size.height * 0.5089000,
        size.width * -0.01274309,
        size.height * 0.7278786,
        size.width * 0.1732804,
        size.height * 0.6560464);
    path_0.cubicTo(
        size.width * 0.6064817,
        size.height * 0.4887714,
        size.width * 0.5137644,
        size.height * 0.5284429,
        size.width * 0.8090733,
        size.height * 0.8766571);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = ColorConstants.backgroundClipperColor.withOpacity(1);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AuthBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*0.8588320,size.height*0.9064065);
    path_0.cubicTo(size.width*1.089088,size.height*1.107043,size.width*1.414704,size.height*0.9283957,size.width*1.472552,size.height*0.8589106);
    path_0.lineTo(size.width*0.7923787,size.height*-0.4336043);
    path_0.lineTo(size.width*-0.4690587,size.height*0.2519794);
    path_0.cubicTo(size.width*-0.4694213,size.height*0.2763848,size.width*-0.4463200,size.height*0.3554146,size.width*-0.3510267,size.height*0.4762737);
    path_0.cubicTo(size.width*-0.2319104,size.height*0.6273496,size.width*0.01497192,size.height*0.7935122,size.width*0.2059851,size.height*0.7390054);
    path_0.cubicTo(size.width*0.6508053,size.height*0.6120759,size.width*0.5556027,size.height*0.6421789,size.width*0.8588320,size.height*0.9064065);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffDDF0FF).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxHeight - shrinkOffset,
      // Adjust the height based on shrinkOffset
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight; // Adjust the minExtent value

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}