import 'package:flutter/material.dart';
import 'package:aerium/core/layout/adaptive.dart';
import 'package:aerium/presentation/pages/portfolio/portfolio_page.dart';
import 'package:aerium/presentation/widgets/app_drawer.dart';
import 'package:aerium/presentation/widgets/circular_container.dart';
import 'package:aerium/presentation/widgets/content_wrapper.dart';
import 'package:aerium/presentation/widgets/socials.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/values/values.dart';
import 'dart:ui' as ui;
import 'home_page.dart';

class HomePageMobile extends StatefulWidget {
  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        menuList: Data.menuList,
        selectedItemRouteName: HomePage.homePageRoute,
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    ContentWrapper(
                      width: assignWidth(context: context, fraction: 0.8),
                      color: AppColors.primaryColor,
//                        gradient: Gradients.primaryGradient,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: assignHeight(
                                context: context,
                                fraction: 0.2,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: ListBody(
                                children: [
                                  Text(
                                    StringConst.DEV_NAME,
                                    style: theme.textTheme.headlineMedium!.copyWith(
                                      color:  const ui.Color.fromARGB(255, 255, 191, 206),
                                    ),
                                  ),
                                  SpaceH8(),
                                  Text(
                                    StringConst.SPECIALITY,
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      color:  const ui.Color.fromARGB(255, 255, 191, 206),
                              
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(flex: 1),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  PortfolioPage.portfolioPageRoute,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Column(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        StringConst.VIEW_PORTFOLIO,
                                        textAlign: TextAlign.end,
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: Sizes.TEXT_SIZE_18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SpaceH12(),
                                    CircularContainer(
                                      width: Sizes.WIDTH_24,
                                      height: Sizes.HEIGHT_24,
                                      color:  const ui.Color.fromARGB(255, 255, 191, 206),
                      
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: assignHeight(
                                context: context,
                                fraction: 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ContentWrapper(
                      width: assignWidth(context: context, fraction: 0.2),
                      color:  const ui.Color.fromARGB(255, 255, 191, 206),
                            
                      child: Container(),
                    ),
                  ],
                )
              ],
            ),
            _buildAppBar(),
            _buildDevImage(),
            _buildSocials(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: Sizes.PADDING_16,
      vertical: Sizes.PADDING_16,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            if (_scaffoldKey.currentState!.isEndDrawerOpen) {
              _scaffoldKey.currentState!.openEndDrawer();
            } else {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: Icon(Icons.menu),
          color:  const ui.Color.fromARGB(255, 255, 191, 206),
        ),
      ],
    ),
  );
}


  Widget _buildDevImage() {
    return Positioned(
      top: 56,
      right: -assignWidth(context: context, fraction: 0.42),
      child: Container(
        child: Image.asset(
          ImagePath.DEV,
          height: assignHeight(context: context, fraction: 1),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSocials() {
    return Positioned(
      right: Sizes.SIZE_16,
      bottom: Sizes.SIZE_30,
      child: Socials(
        isVertical: true,
        alignment: Alignment.centerRight,
        color:  const ui.Color.fromARGB(255, 255, 191, 206),
                              
        barColor:  const ui.Color.fromARGB(255, 255, 191, 206),
                                
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }
}
