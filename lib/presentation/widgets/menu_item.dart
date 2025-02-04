import 'package:flutter/material.dart';
import 'package:aerium/presentation/widgets/horizontal_bar.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/values/values.dart';
import 'dart:ui' as ui;

import 'flicker_text_animation.dart';

class MenuItem extends StatefulWidget {
  MenuItem({
    required this.title,
    this.titleStyle,
    this.onTap,
    this.selectedStyle,
    this.isMobile = false,
    this.selected = false,
  });

  final String title;
  final TextStyle? titleStyle;
  final TextStyle? selectedStyle;
  final bool selected;
  final bool isMobile;
  final GestureTapCallback? onTap;

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with TickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAnimationOnHover() {
    if (_hovering) {
      _playAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(
            widget.isMobile ? Sizes.PADDING_8 : Sizes.PADDING_2,
          ),
          child: !widget.isMobile
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.selected
                        ? Container(
                            width: 2,
                            height: 18,
                            color:const ui.Color.fromARGB(255, 255, 191, 206),
                          )
                        : Container(),
                    widget.selected ? SpaceW12() : Container(),
                    FlickerTextAnimation(
                      text: widget.title,
                      textColor:const ui.Color.fromARGB(255, 255, 191, 206),
                      fadeInColor: AppColors.accentColor,
                      controller: _controller.view,
                      textStyle: !widget.selected
                          ? theme.textTheme.bodyLarge!
                              .copyWith(fontSize: Sizes.TEXT_SIZE_16)
                          : null,
                    ),
                  ],
                )
              : //This menuList shows only on mobile
              Column(
                  children: [
                    FlickerTextAnimation(
                      text: widget.title,
                      textColor: const ui.Color.fromARGB(255, 255, 191, 206),
                      fadeInColor: AppColors.primaryColor,
//                      mainAxisAlignment: MainAxisAlignment.center,
                      controller: _controller.view,
                      textStyle: !widget.selected
                          ? theme.textTheme.bodyLarge!.copyWith(
                              fontSize: Sizes.TEXT_SIZE_16,
                              color: const Color.fromARGB(255, 0, 0, 0)
                            )
                          : null,
                    ),
                    widget.selected ? SpaceH8() : Container(),
                    widget.selected
                        ? HorizontalBar(
                            color: const Color.fromARGB(255, 255, 255, 255),
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
    _showAnimationOnHover();
  }
}
