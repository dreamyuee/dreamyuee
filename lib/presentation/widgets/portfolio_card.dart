import 'package:flutter/material.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/values/values.dart';
import 'dart:ui' as ui;

class PortfolioCard extends StatefulWidget {
  PortfolioCard({
    this.width = 500,
    this.height = 400,
    this.imageUrl,
    this.elevation,
    this.shadow,
    this.title,
    this.subtitle,
    this.actionTitle,
    this.hoverColor = AppColors.primaryColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.actionTitleTextStyle,
    this.duration = 1000,
    this.onTap,
    this.projectDescription,
    this.additionalDescription, // New additional description field
    this.subtitleColor,
  });

  final double width;
  final double height;
  final String? imageUrl;
  final double? elevation;
  final Shadow? shadow;
  final String? title;
  final String? subtitle;
  final String? actionTitle;
  final Color hoverColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final TextStyle? actionTitleTextStyle;
  final int duration;
  final GestureTapCallback? onTap;
  final String? projectDescription;
  final String? additionalDescription; // New additional description
  final Color? subtitleColor;

  @override
  _PortfolioCardState createState() => _PortfolioCardState();
}
class _PortfolioCardState extends State<PortfolioCard> with TickerProviderStateMixin {
  late AnimationController _portfolioCoverController;
  late AnimationController _expandController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeFactorAnimation;
  bool _hovering = false;
  bool _isExpanded = false; // Track expanded state for the description
  bool _buttonHovered = false; // Track button hover state
  bool _descriptionHovered = false; // Track description hover state

  @override
  void initState() {
    // Hover effect animation controller
    _portfolioCoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Expand/Collapse animation controller
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Opacity animation for hover effect
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _portfolioCoverController,
        curve: Curves.easeIn,
      ),
    );

    // Size animation for expanding/collapsing the description
    _sizeFactorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.easeInOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _portfolioCoverController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: MouseRegion(
          onEnter: (_) => _mouseEnter(true),
          onExit: (_) => _mouseEnter(false),
          child: Stack(
            children: [
              // Background Image
              Image.asset(
                widget.imageUrl!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              ),

              // Hover Effect
              _hovering
                  ? FadeTransition(
                      opacity: _opacityAnimation,
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        color: widget.hoverColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),

                            // Title
                            Text(
                              widget.title!,
                              textAlign: TextAlign.center,
                              style: widget.titleTextStyle ??
                                  theme.textTheme.headlineMedium!.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                            SpaceH4(),

                            // Subtitle
                            Text(
                              widget.subtitle!,
                              textAlign: TextAlign.center,
                              style: widget.subtitleTextStyle ??
                                  theme.textTheme.bodyLarge!.copyWith(
                                    color: widget.subtitleColor!,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SpaceH4(),

                            // Project Description
                            Text(
                              widget.projectDescription!,
                              textAlign: TextAlign.center,
                              style: widget.subtitleTextStyle ??
                                  theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                  ),
                            ),
                            SpaceH8(),

                            // Additional Description Section with Hover Effect
                            MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  _descriptionHovered = true; // Set hover state for description
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  _descriptionHovered = false; // Reset hover state for description
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded; // Toggle expanded state
                                    if (_isExpanded) {
                                      _expandController.forward(); // Play expand animation
                                    } else {
                                      _expandController.reverse(); // Reverse expand animation
                                    }
                                  });
                                },
                                child: Column(
                                  children: [
                                    // Title with Icon
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: _descriptionHovered
                                            ? AppColors.primaryColor.withOpacity(0.2) // Highlight background on hover
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "  Description",
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodySmall!.copyWith(
                                              color: _descriptionHovered
                                                  ? widget.subtitleColor
                                                  : AppColors.secondaryColor,
                                                   // Change text color on hover
                                              fontSize: Sizes.TEXT_SIZE_16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 4.0),
                                          Icon(
                                            _isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: _descriptionHovered
                                                  ? widget.subtitleColor
                                                  : AppColors.secondaryColor, // Change icon color on hover
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Expandable Description Content
                                    SizeTransition(
                                      sizeFactor: _sizeFactorAnimation,
                                      axisAlignment: 1.0, // Expand downward
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 16.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(200, 0, 0, 0),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Text(
                                          widget.additionalDescription!,
                                          textAlign: TextAlign.justify,
                                          style: theme.textTheme.bodyMedium!.copyWith(
                                            color: AppColors.secondaryColor,
                                            fontSize: Sizes.TEXT_SIZE_14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SpaceH8(),

                            // Action Button with Hover Effect
                            MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  _buttonHovered = true;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  _buttonHovered = false;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: _buttonHovered
                                      ? widget.subtitleColor!.withOpacity(0.8)
                                      : widget.subtitleColor!,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: _buttonHovered
                                      ? [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8.0,
                                            offset: Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Text(
                                  widget.actionTitle!,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: _buttonHovered
                                        ? Colors.white
                                        : const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });

    if (_hovering) {
      _portfolioCoverController.forward();
    } else {
      _portfolioCoverController.reverse();
    }
  }
}
