import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Анимация портала при удалении карточки из избранного
class PortalTransition extends StatefulWidget {
  final Widget child;
  final bool show;
  final VoidCallback? onDismissed;

  const PortalTransition({
    super.key,
    required this.child,
    required this.show,
    this.onDismissed,
  });

  @override
  State<PortalTransition> createState() => _PortalTransitionState();
}

class _PortalTransitionState extends State<PortalTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Анимация уменьшения (как засасывание в портал)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInBack,
      ),
    );
    
    // Анимация прозрачности
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    
    // Анимация вращения
    _rotationAnimation = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDismissed?.call();
      }
    });
  }

  @override
  void didUpdateWidget(PortalTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (!widget.show && oldWidget.show) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show && _controller.status == AnimationStatus.completed) {
      return const SizedBox.shrink();
    }
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value * 3.14159,
              child: Stack(
                children: [
                  // Эффект портала (круги расширяются)
                  if (_controller.value > 0 && _controller.value < 0.7)
                    Center(
                      child: Container(
                        width: 200 * (1 - _controller.value),
                        height: 200 * (1 - _controller.value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.portalGreen.withValues(
                              alpha: (1 - _controller.value) * 0.8,
                            ),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  
                  // Основной контент
                  widget.child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Анимация появления карточки (телепортация из портала)
class PortalEntrance extends StatefulWidget {
  final Widget child;
  final int index;

  const PortalEntrance({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<PortalEntrance> createState() => _PortalEntranceState();
}

class _PortalEntranceState extends State<PortalEntrance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Задержка появления в зависимости от индекса
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _controller.forward();
      }
    });
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              children: [
                // Эффект портального свечения при появлении
                if (_controller.value > 0 && _controller.value < 0.5)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.portalGreen.withValues(
                              alpha: (0.5 - _controller.value) * 1.5,
                            ),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                
                widget.child,
              ],
            ),
          ),
        );
      },
    );
  }
}

