import 'package:flutter/material.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/presentation/widgets/horizontal_bar.dart';
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

class _PortfolioCardState extends State<PortfolioCard>
    with TickerProviderStateMixin {
  late AnimationController _portfolioCoverController;
  late AnimationController _expandController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _expandAnimation; // For additional description
  final int duration = 400;
  bool _hovering = false;

  @override
  void initState() {
    _portfolioCoverController = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );

    _expandController = AnimationController(
      duration: Duration(milliseconds: 300), // Expand animation duration
      vsync: this,
    );

    initTweens();

    super.initState();
  }

  @override
  void dispose() {
    _portfolioCoverController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  void initTweens() {
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _portfolioCoverController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _expandAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _playPortfolioCoverAnimation() async {
    try {
      await _portfolioCoverController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
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
          onEnter: (e) => _mouseEnter(true),
          onExit: (e) => _mouseEnter(false),
          child: Stack(
            children: [
              Image.asset(
                widget.imageUrl!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              ),
              _hovering
                  ? FadeTransition(
                      opacity: _opacityAnimation,
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        color: widget.hoverColor,
                        child: Column(
                          children: [
                            Spacer(flex: 1),
                            Text(
                              widget.title!,
                              textAlign: TextAlign.center,
                              style: widget.titleTextStyle ??
                                  theme.textTheme.headlineMedium!.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                            SpaceH4(),
                            Text(
                              widget.subtitle!,
                              textAlign: TextAlign.center,
                              style: widget.subtitleTextStyle ??
                                  theme.textTheme.bodyLarge!.copyWith(
                                      // color: const Color.fromARGB(255, 221, 114, 139),
                                      color : widget.subtitleColor!,
                                      fontSize: Sizes.TEXT_SIZE_16,
                                      fontWeight: FontWeight.bold),
                            ),
                            SpaceH4(),
                            Text(
                              widget.projectDescription!,
                              textAlign: TextAlign.center,
                              style: widget.subtitleTextStyle ??
                                  theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: Sizes.TEXT_SIZE_16),
                            ),
                            // New additional description section
                            SizeTransition(
                            sizeFactor: _expandAnimation,
                            axisAlignment: 1.0,
                            child: Column(
                              children: [
                                ExpansionTile(
                                  title: Center(
                                    child: Text(
                                      "          Description",
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall!.copyWith(
                                        color: AppColors.secondaryColor,
                                        fontSize: Sizes.TEXT_SIZE_16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  collapsedIconColor: Colors.transparent, // 可选：隐藏默认图标
                                  tilePadding: EdgeInsets.zero, // 去掉默认 tile 内间距
                                  children: [
                                    // Semi-transparent container for detailed description
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 16.0, // Reduced vertical padding for tighter spacing
                                      ), 

                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(200, 0, 0, 0),// Semi-transparent black background
                                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                      ),
                                      child: Text(
                                        widget.additionalDescription!,
                                        textAlign: TextAlign.justify,
                                        style: theme.textTheme.bodyMedium!.copyWith(
                                          color: AppColors.secondaryColor, // Slightly lighter white for readability
                                          fontSize: Sizes.TEXT_SIZE_14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                           SpaceH8(),
                            InkWell(
                              onTap: widget.onTap, // Use the provided onTap callback
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: widget.subtitleColor!, // Add a background color for the button
                                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                                ),
                                child: Text(
                                  widget.actionTitleTextStyle as String? ?? widget.actionTitle!, // Use the provided actionTitle or fallback to "View"
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: const Color.fromARGB(255, 0, 0, 0), // White text for contrast
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            Spacer(flex: 1),
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

    if (_hovering == true) {
      _playPortfolioCoverAnimation();
      _expandController.forward(); // Play expand animation
    } else if (_hovering == false) {
      _portfolioCoverController.reverse().orCancel;
      _expandController.reverse(); // Reverse expand animation
    }
  }
}
