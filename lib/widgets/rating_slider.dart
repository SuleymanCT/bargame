import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class RatingSlider extends StatefulWidget {
  final int min;
  final int max;
  final double value;
  final ValueChanged<double> onChanged;

  const RatingSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  @override
  State<RatingSlider> createState() => _RatingSliderState();
}

class _RatingSliderState extends State<RatingSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _getRatingGradient(widget.value),
            boxShadow: [
              BoxShadow(
                color: _getRatingColor(widget.value).withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.value.toInt().toString(),
                  style: AppTheme.textTheme.displayLarge?.copyWith(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _getRatingText(widget.value),
                  style: AppTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 40),
        
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 8,
            activeTrackColor: _getRatingColor(widget.value),
            inactiveTrackColor: AppTheme.cardColor,
            thumbColor: _getRatingColor(widget.value),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 14,
            ),
            overlayColor: _getRatingColor(widget.value).withOpacity(0.2),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 28,
            ),
          ),
          child: Slider(
            value: widget.value,
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            divisions: widget.max - widget.min,
            onChanged: widget.onChanged,
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.min}',
                style: AppTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                '${widget.max}',
                style: AppTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRatingColor(double rating) {
    if (rating <= 3) return AppTheme.successColor;
    if (rating <= 6) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  LinearGradient _getRatingGradient(double rating) {
    final color = _getRatingColor(rating);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color, color.withOpacity(0.7)],
    );
  }

  String _getRatingText(double rating) {
    if (rating <= 2) return 'Hiç';
    if (rating <= 4) return 'Az';
    if (rating <= 6) return 'Orta';
    if (rating <= 8) return 'Çok';
    return 'Aşırı!';
  }
}