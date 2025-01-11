import 'package:flutter/material.dart';
import 'package:aerium/core/layout/adaptive.dart';
import 'package:aerium/presentation/pages/about/about_page.dart';
import 'package:aerium/presentation/widgets/content_wrapper.dart';
import 'package:aerium/presentation/widgets/flicker_text_animation.dart';
import 'package:aerium/presentation/widgets/menu_list.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
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
      end: 0.65,
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
                      // fraction: 0.6,
                      fraction: widthOfAboutContent.value,
                    ),
                    child: _isAboutContentVisible
                        ? aboutPageContent()
                        : Container(),
                  ),
                  // SizedBox(
                  //   width: assignWidth(
                  //     context: context,
                  //     fraction: 0.025,
                  //   ),
                  // ),
                  // TrailingInfo(
                  //   width: assignWidth(context: context, fraction: 0.075),
                  //   onTrailingWidgetPressed: () => Navigator.pushNamed(
                  //     context,
                  //     PortfolioPage.portfolioPageRoute,
                  //   ),
                  // ),
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
Widget aboutPageContent() {
  ThemeData theme = Theme.of(context);
    bool _isExpanded = false; // Add a local variable to track the expanded state

  return StatefulBuilder( // Use StatefulBuilder for state management within this widget
    builder: (context, setState) {
      final String fullText = StringConst.ABOUT_DEV_TEXT;
      final String partialText = fullText.length > 200 
          ? fullText.substring(0, 200) + "..." 
          : fullText; // Ensure we don't cut short text

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
            // FlickerTextAnimation(
            //   text: "Introduction", // Replace StringConst.INTRO with "Introduction"
            //   textColor: AppColors.primaryColor,
            //   fadeInColor: AppColors.primaryColor,
            //   controller: _flickerAnimationController.view,
            //   textStyle: theme.textTheme.bodyLarge!.copyWith(
            //     fontSize: Sizes.TEXT_SIZE_18,
            //     fontWeight: FontWeight.w400,
            //     color: AppColors.accentColor2,
            //   ),
            // ),
            FlickerTextAnimation(
              text: "Yue Wen", // Replace StringConst.DEV_NAME with your name
              textColor: AppColors.primaryColor,
              fadeInColor: AppColors.primaryColor,
              fontSize: Sizes.TEXT_SIZE_34,
              controller: _flickerAnimationController.view,
            ),
            // _isSubtitleVisible
            //     ? FlickerTextAnimation(
            //         text: "I'm an engineer with a background in circuits and control systems, but I've always been more interested in how humans interact with the technology I build. In my work, I focus on creating systems that balance technical precision with user-friendly design—like reducing the learning burden for users when there are limited buttons or implementing fault-tolerant mechanisms to prevent user errors. This approach has a lot in common with Human-Computer Interaction (HCI), though at the time, I didn’t realize how much I cared about the human side of things.\n\nEverything changed when I took a course on user-centered design. It was like a lightbulb went off! I realized that the process of understanding users' needs and then using technology to meet those needs was exactly what I loved. This spark led me to shift from pure engineering to design, where I could create solutions that bridge the gap between technology and real people. And so, my new journey began. Now, I'm excited to keep exploring how design can shape the technology we use every day. My journey into this new world of design is just beginning, and I can't wait to see where it leads next.", // Replace StringConst.PUNCH_LINE
            //         // text:"I’m an engineer with a background in circuits and control systems, but I have always been more interested in how humans interact with the technology I build.  In my work, I focus on creating systems that balance technical precision with user-friendly design—like reducing the learning burden for users when there are limited buttons or implementing fault-tolerant mechanisms to prevent user errors.",
            //         textColor: AppColors.primaryColor,
            //         fadeInColor: AppColors.primaryColor,
            //         controller: _flickerAnimationController2.view,
            //         textStyle: theme.textTheme.bodyMedium!.copyWith(
            //           fontSize: Sizes.TEXT_SIZE_18,
            //           color: AppColors.accentColor2,
            //         ),
            //       )
            //     : Container(),
            SpaceH16(),
             // About Me Section with Read More/Read Less
                AnimatedOpacity(
                  opacity: _visible ? aboutDevAnimation.value : 0.0,
                  duration: _aboutDevAnimationController.duration!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expandable About Me Text
                      AnimatedCrossFade(
                        firstChild: Text(
                          partialText,
                          textAlign: TextAlign.justify,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.black,
                            fontSize: Sizes.TEXT_SIZE_16,
                            height: 1.6, // Improve readability
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        secondChild: Text(
                          fullText,
                          textAlign: TextAlign.justify,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.black,
                            fontSize: Sizes.TEXT_SIZE_16,
                            fontWeight: FontWeight.normal,
                            height: 1.6,
                          ),
                        ),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 300),
                      ),

                      // Read More/Read Less Button
                     
                        TextButton(
                        onPressed: () {
                          setState(() {
                          _isExpanded = !_isExpanded; // Toggle state
                          });
                        },
                        child: Text(
                          _isExpanded ? "Read Less" : "Read More",
                          style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.normal,
                          ),
                        )
                        ),
                    ],
                  ),
                ),
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
                        "2024    China College Computer Competition\n             Mobile Application Innovation Contest \n(East China Region)\n             Second Prize: Silent But Tangible",
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
                  child: Container(
                    width: 350, // Narrow the width of the skills section (adjust as needed)
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 20, // Horizontal spacing
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
                ),

                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
},
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
