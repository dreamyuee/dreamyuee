import 'package:flutter/material.dart';
import 'package:aerium/core/layout/adaptive.dart';
import 'package:aerium/presentation/pages/about/about_page.dart';
import 'package:aerium/presentation/pages/portfolio/portfolio_page.dart';
import 'package:aerium/presentation/widgets/content_wrapper.dart';
import 'package:aerium/presentation/widgets/flicker_text_animation.dart';
import 'package:aerium/presentation/widgets/menu_list.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/presentation/widgets/trailing_info.dart';
import 'package:aerium/values/values.dart';


class AboutPageDesktop extends StatefulWidget {
  @override
  _AboutPageDesktopState createState() => _AboutPageDesktopState();
}

class _AboutPageDesktopState extends State<AboutPageDesktop>
    with TickerProviderStateMixin {
  double? widthOfImage;
  late AnimationController _controller;
  late AnimationController _flickerAnimationController;
  late AnimationController _flickerAnimationController2;
  late AnimationController _aboutDevAnimationController;
  late Animation<double> widthOfLeftSide;
  late Animation<double> widthOfRightSide;
  late Animation<double> widthOfAboutContent;
  late Animation<double> heightPositionOfImage;
  late Animation<double> widthPositionOfImage;
  late Animation<double> aboutDevAnimation;
  late AnimationController _contentAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> scale;
  bool _isAboutContentVisible = false;
  bool _visible = false;
  bool _isSubtitleVisible = false;
  bool _isSubMenuListVisible = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _flickerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _flickerAnimationController2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _aboutDevAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );


    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    initializeTweens();
    _playAnimation();


    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAboutContentVisible = true;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _playFlickerAnimation();
        });
      }
    });

    _flickerAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSubtitleVisible = true;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _playFlickerAnimation2();
        });
      }
    });

    _flickerAnimationController2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _visible = true;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _playAboutDevAnimation();
        });
      }
    });
    // Initialize Slide and Fade Animations
_slideAnimation = Tween<Offset>(
    begin: Offset(1.0, 0.0), // Start from off-screen right
    end: Offset.zero,        // End at original position
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  _fadeAnimation = Tween<double>(
    begin: 0.0, // Fully transparent
    end: 1.0,   // Fully visible
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  _controller.forward();

  // Start the animation
  _controller.forward();

    _aboutDevAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSubMenuListVisible = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _flickerAnimationController.dispose();
    _flickerAnimationController2.dispose();
    _aboutDevAnimationController.dispose();
    super.dispose();
  }

  initializeTweens() {
    widthOfLeftSide = Tween<double>(
      begin: 0.5,
      end: 0.3,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
    widthOfRightSide = Tween<double>(
      begin: 0.5,
      end: 0.7,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
    widthOfAboutContent = Tween<double>(
      begin: 0.4,
      end: 0.6,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
    widthPositionOfImage = Tween<double>(
      begin: 0.5,
      end: 0.3,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
    heightPositionOfImage = Tween<double>(
      begin: 0.4,
      end: 0.05,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
    scale = Tween<double>(
      begin: 1.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );

    aboutDevAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _aboutDevAnimationController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  Future<void> _playFlickerAnimation() async {
    try {
      await _flickerAnimationController.forward().orCancel;
      await _flickerAnimationController.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  Future<void> _playFlickerAnimation2() async {
    try {
      await _flickerAnimationController2.forward().orCancel;
      await _flickerAnimationController2.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  Future<void> _playAboutDevAnimation() async {
    try {
      await _aboutDevAnimationController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

@override
Widget _buildAnimation(BuildContext context, Widget? child) {
  double heightOfImage = assignHeight(context: context, fraction: 1);
  widthOfImage = assignWidth(context: context, fraction: 0.67);

  return Stack(
    children: <Widget>[
      // Left Menu Section
      Positioned.fill(
        child: Row(
          children: [
            ContentWrapper(
              width: assignWidth(
                context: context,
                fraction: widthOfLeftSide.value,
              ),
              color: AppColors.primaryColor,
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.MARGIN_20,
                  top: Sizes.MARGIN_20,
                  bottom: Sizes.MARGIN_20,
                ),
                child: MenuList(
                  menuList: Data.menuList,
                  selectedItemRouteName: AboutPage.aboutPageRoute,
                ),
              ),
            ),
            ContentWrapper(
              width: assignWidth(
                context: context,
                fraction: widthOfRightSide.value,
              ),
              color: const Color.fromARGB(255, 255, 237, 237),
              child: Row(
                children: [
                  Container(
                    width: assignWidth(
                      context: context,
                      fraction: widthOfAboutContent.value,
                    ),
                    child: _isAboutContentVisible
                        ? aboutPageContent()
                        : Container(),
                  ),
                  SizedBox(
                    width: assignWidth(
                      context: context,
                      fraction: 0.025,
                    ),
                  ),
                  TrailingInfo(
                    width: assignWidth(context: context, fraction: 0.075),
                    onTrailingWidgetPressed: () => Navigator.pushNamed(
                      context,
                      PortfolioPage.portfolioPageRoute,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Profile Image (Simplified without Transform.scale)
      Positioned(
        top: assignHeight(context: context, fraction: 0.05),
        left: assignWidth(context: context, fraction: widthPositionOfImage.value) -
            widthOfImage! / 2,
        child: IgnorePointer(
          ignoring: true, // This ensures the image doesn't block interactions
          child: isDisplaySmallDesktopOrIpadPro(context)
              ? Container(
                  width: widthOfImage,
                )
              : Image.asset(
                  ImagePath.DEV,
                  width: widthOfImage,
                  height: heightOfImage,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          builder: _buildAnimation,
          animation: _controller.view,
        ),
      ),
    );
  }

  // Widget aboutPageContent() {
  //   ThemeData theme = Theme.of(context);

  //   return ListView(
  //     padding: EdgeInsets.all(Sizes.PADDING_0),
  //     children: [
  //       Container(
  //         padding: EdgeInsets.only(
  //           left: (widthOfImage! / 2) + 20,
  //           top: isDisplaySmallDesktopOrIpadPro(context)
  //               ? assignHeight(context: context, fraction: 0.05)
  //               : assignHeight(context: context, fraction: 0.12),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             FlickerTextAnimation(
  //               text: StringConst.INTRO,
  //               textColor: AppColors.primaryColor,
  //               fadeInColor: AppColors.primaryColor,
  //               controller: _flickerAnimationController.view,
  //               textStyle: theme.textTheme.bodyLarge!.copyWith(
  //                 fontSize: Sizes.TEXT_SIZE_18,
  //                 fontWeight: FontWeight.w400,
  //                 color: AppColors.accentColor2,
  //               ),
  //             ),
  //             FlickerTextAnimation(
  //               text: StringConst.DEV_NAME,
  //               textColor: AppColors.primaryColor,
  //               fadeInColor: AppColors.primaryColor,
  //               fontSize: Sizes.TEXT_SIZE_34,
  //               controller: _flickerAnimationController.view,
  //             ),
  //             _isSubtitleVisible
  //                 ? FlickerTextAnimation(
  //                     text: StringConst.PUNCH_LINE,
  //                     textColor: AppColors.primaryColor,
  //                     fadeInColor: AppColors.primaryColor,
  //                     controller: _flickerAnimationController2.view,
  //                     textStyle: theme.textTheme.titleMedium!.copyWith(
  //                       fontSize: Sizes.TEXT_SIZE_34,
  //                       color: AppColors.accentColor2,
  //                     ),
  //                   )
  //                 : Container(),
  //             SpaceH16(),
  //             AnimatedOpacity(
  //               opacity: _visible ? aboutDevAnimation.value : 0.0,
  //               duration: _aboutDevAnimationController.duration!,
  //               child: Text(
  //                 StringConst.ABOUT_DEV_TEXT,
  //                 style: theme.textTheme.bodyMedium!.copyWith(
  //                   color: AppColors.black,
  //                   fontSize: Sizes.TEXT_SIZE_16,
  //                 ),
  //               ),
  //             ),
  //             SpaceH40(),
  //             _isSubMenuListVisible
  //                 ? SubMenuList(
  //                     subMenuData: Data.subMenuData,
  //                     width: assignWidth(
  //                         context: context,
  //                         fraction: 0.6,
  //                         subs: (widthOfImage! / 2) + 20),
  //                   )
  //                 : Container(),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

Widget aboutPageContent() {
  ThemeData theme = Theme.of(context);

  return ListView(
    padding: EdgeInsets.all(Sizes.PADDING_0),
    children: [
      Container(
        padding: EdgeInsets.only(
          left: (widthOfImage! / 2) + 20,
          top: isDisplaySmallDesktopOrIpadPro(context)
              ? assignHeight(context: context, fraction: 0.05)
              : assignHeight(context: context, fraction: 0.12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlickerTextAnimation(
              text: "Introduction", // Replace StringConst.INTRO with "Introduction"
              textColor: AppColors.primaryColor,
              fadeInColor: AppColors.primaryColor,
              controller: _flickerAnimationController.view,
              textStyle: theme.textTheme.bodyLarge!.copyWith(
                fontSize: Sizes.TEXT_SIZE_18,
                fontWeight: FontWeight.w400,
                color: AppColors.accentColor2,
              ),
            ),
            FlickerTextAnimation(
              text: "Yue Wen", // Replace StringConst.DEV_NAME with your name
              textColor: AppColors.primaryColor,
              fadeInColor: AppColors.primaryColor,
              fontSize: Sizes.TEXT_SIZE_34,
              controller: _flickerAnimationController.view,
            ),
            _isSubtitleVisible
                ? FlickerTextAnimation(
                    text: "Purposeful Design, Meaningful Technology", // Replace StringConst.PUNCH_LINE
                    textColor: AppColors.primaryColor,
                    fadeInColor: AppColors.primaryColor,
                    controller: _flickerAnimationController2.view,
                    textStyle: theme.textTheme.titleMedium!.copyWith(
                      fontSize: Sizes.TEXT_SIZE_34,
                      color: AppColors.accentColor2,
                    ),
                  )
                : Container(),
            SpaceH16(),
            AnimatedOpacity(
              opacity: _visible ? aboutDevAnimation.value : 0.0,
              duration: _aboutDevAnimationController.duration!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Education Section
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Education",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SpaceH16(),
                  Text(
                    "2021.9 - Present    Shanghai Jiao Tong University\nMajor: Measurement Control Technology and Instrument",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.black87,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  SpaceH40(),

                  // Internship Section
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Internship",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SpaceH16(),
                  Text(
                    "2023.7 - 2023.9    Future Lab, Tsinghua University\nHCI Researcher",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.black87,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  SpaceH40(),

                  // Awards Section
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Awards",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SpaceH16(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2022, 2023, 2024   Excellent B Scholarship",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.black87,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SpaceH8(),
                      Text(
                        "2023    Huawei Scholarship",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.black87,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SpaceH8(),
                      Text(
                        "2024    China College Computer Competition\n            Mobile Application Innovation Contest (East China Region)\n            Second Prize: Silent But Tangible",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.black87,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  SpaceH40(),

                  // Skills Section
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Skills",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SpaceH16(),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30, // Horizontal spacing
                      runSpacing: 20, // Vertical spacing
                      children: [
                        _buildSkillIcon('assets/images/figma.png'),
                        _buildSkillIcon('assets/images/ps.png'),
                        _buildSkillIcon('assets/images/sw.png'),
                        _buildSkillIcon('assets/images/swift.png'),
                        _buildSkillIcon('assets/images/python.png'),
                        _buildSkillIcon('assets/images/c++.png'),
                        _buildSkillIcon('assets/images/arduino.png'),
                        _buildSkillIcon('assets/images/rs.png'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Helper function to build skill icons
Widget _buildSkillIcon(String assetPath) {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromARGB(255, 255, 237, 237),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
      ),
    ),
  );
}

}
