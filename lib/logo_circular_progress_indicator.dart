import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Enum for different loader animation styles
enum LoaderStyle { gradient, dottedCircle, dualRing, wave, spinningArcs }

class CustomLoader extends StatefulWidget {
  const CustomLoader({
    super.key,
    this.size = 40,
    this.color,
    this.strokeWidth = 3.5,
    this.logoAsset,
    this.logo,
    this.style = LoaderStyle.gradient,
  });

  final double size;
  final Color? color;
  final double strokeWidth;
  final String? logoAsset;
  final Widget? logo;
  final LoaderStyle style;

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loaderColor = widget.color ?? Theme.of(context).primaryColor;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: loaderColor.withValues(alpha: 0.1),
                ),
              ),
              // Style-specific animation
              _buildLoaderByStyle(loaderColor),
              // Inner white circle (creates ring effect)
              Container(
                width: widget.size - (widget.strokeWidth * 2),
                height: widget.size - (widget.strokeWidth * 2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              // Center logo with pulse animation
              ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.1).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: _buildCenterLogo(loaderColor),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoaderByStyle(Color color) {
    switch (widget.style) {
      case LoaderStyle.gradient:
        return _buildGradientLoader(color);
      case LoaderStyle.dottedCircle:
        return _buildDottedCircleLoader(color);
      case LoaderStyle.dualRing:
        return _buildDualRingLoader(color);
      case LoaderStyle.wave:
        return _buildWaveLoader(color);
      case LoaderStyle.spinningArcs:
        return _buildSpinningArcsLoader(color);
    }
  }

  Widget _buildGradientLoader(Color color) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              color.withValues(alpha: 0.0),
              color.withValues(alpha: 0.3),
              color,
              color,
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildDottedCircleLoader(Color color) {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: DottedCirclePainter(
          color: color,
          dotCount: 12,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }

  Widget _buildDualRingLoader(Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
          turns: _controller,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: ArcPainter(
              color: color,
              strokeWidth: widget.strokeWidth,
              sweepAngle: math.pi * 0.75,
            ),
          ),
        ),
        RotationTransition(
          turns: Tween<double>(begin: 1.0, end: 0.0).animate(_controller),
          child: CustomPaint(
            size: Size(widget.size * 0.7, widget.size * 0.7),
            painter: ArcPainter(
              color: color.withValues(alpha: 0.5),
              strokeWidth: widget.strokeWidth,
              sweepAngle: math.pi * 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWaveLoader(Color color) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: WavePainter(
        color: color,
        strokeWidth: widget.strokeWidth,
        progress: _controller.value,
      ),
    );
  }

  Widget _buildSpinningArcsLoader(Color color) {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: SpinningArcsPainter(
          color: color,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }

  Widget _buildCenterLogo(Color color) {
    // If custom logo widget provided
    if (widget.logo != null) {
      return Container(
        width: widget.size * 0.5,
        height: widget.size * 0.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipOval(child: widget.logo!),
      );
    }

    // If asset path provided
    if (widget.logoAsset != null) {
      return Container(
        width: widget.size * 0.5,
        height: widget.size * 0.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            widget.logoAsset!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildFallbackDot(color),
          ),
        ),
      );
    }

    // Fallback to dot
    return _buildFallbackDot(color);
  }

  Widget _buildFallbackDot(Color color) {
    return Container(
      width: widget.size * 0.25,
      height: widget.size * 0.25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

/// Full screen loader overlay
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    super.key,
    this.message,
    this.size = 60,
    this.style = LoaderStyle.gradient,
    this.logoAsset,
    this.logo,
  });

  final String? message;
  final double size;
  final LoaderStyle style;
  final String? logoAsset;
  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomLoader(
                size: size,
                style: style,
                logoAsset: logoAsset,
                logo: logo,
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painters for different loader styles

class DottedCirclePainter extends CustomPainter {
  final Color color;
  final int dotCount;
  final double strokeWidth;

  DottedCirclePainter({
    required this.color,
    this.dotCount = 12,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * math.pi / dotCount) * i;
      final opacity = (i / dotCount);

      paint.color = color.withValues(alpha: opacity);

      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      canvas.drawCircle(Offset(x, y), strokeWidth / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArcPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double sweepAngle;

  ArcPainter({
    required this.color,
    required this.strokeWidth,
    required this.sweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WavePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double progress;

  WavePainter({
    required this.color,
    required this.strokeWidth,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    for (int i = 0; i < 3; i++) {
      final waveProgress = (progress + (i * 0.33)) % 1.0;
      final opacity = 1.0 - waveProgress;
      final currentRadius = radius * (0.5 + waveProgress * 0.5);

      paint.color = color.withValues(alpha: opacity * 0.8);

      canvas.drawCircle(center, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class SpinningArcsPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  SpinningArcsPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw multiple arcs at different positions
    final arcCount = 3;
    final arcLength = math.pi * 0.4;

    for (int i = 0; i < arcCount; i++) {
      final startAngle = (2 * math.pi / arcCount) * i;
      final opacity = 1.0 - (i / arcCount) * 0.5;

      paint.color = color.withValues(alpha: opacity);

      canvas.drawArc(rect, startAngle, arcLength, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
