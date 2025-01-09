import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aerium/core/utils/functions.dart';
import 'package:aerium/presentation/widgets/menu_item.dart';
import 'package:aerium/presentation/widgets/socials.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/values/values.dart';

class MenuList extends StatelessWidget {
  MenuList({
    required this.menuList,
    this.selectedItemRouteName,
  });

  final List<MenuData> menuList;
  final String? selectedItemRouteName;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ..._buildMenuList(menuList: menuList, context: context),
        Spacer(
          flex: 1,
        ),
        Socials(
          isVertical: true,
          alignment: Alignment.centerLeft,
          color: const ui.Color.fromARGB(255, 255, 191, 206),
          barColor: const ui.Color.fromARGB(255, 255, 191, 206),
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        Spacer(
          flex: 1,
        ),
        Padding(
  padding: const EdgeInsets.only(right: 20.0), // 添加右边的额外间距
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        StringConst.DEV_NAME,
        style: theme.textTheme.headlineMedium!.copyWith(
          color: const ui.Color.fromARGB(255, 255, 191, 206),
        ),
      ),
      Text(
        StringConst.PUNCH_LINE,
        style: theme.textTheme.titleLarge!.copyWith(
          color: const ui.Color.fromARGB(255, 255, 191, 206),
        ),
      ),
    ],
  ),
),
        SpaceH20(),
        Row(
          children: [
            Text(
              StringConst.DESIGNED_IN,
              style: theme.textTheme.bodyLarge!.copyWith(
                color:  const ui.Color.fromARGB(255, 255, 191, 206),
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.normal
              ),
            ),
            SpaceW4(),
            Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.red,
              size: Sizes.ICON_SIZE_10,
            )
          ],
        ),
        Wrap(
  children: [
    Text(
      "Inspired by ",
      style: theme.textTheme.bodyLarge!.copyWith(
        color: AppColors.secondaryColor,
        fontSize: Sizes.TEXT_SIZE_10,
      ),
    ),
    GestureDetector(
      onTap: () => Functions.launchUrl("https://davidcobbina.com"), // Opens the creator's website
      child: Text(
        "David Cobbina",
        style: theme.textTheme.bodyLarge!.copyWith(
          color: Colors.blue, // Highlight the text to indicate it's clickable
          fontSize: Sizes.TEXT_SIZE_10,
          decoration: TextDecoration.underline, // Add underline for link style
        ),
      ),
    ),
    Text(
        StringConst.BUILT_BY +  StringConst.DESIGNED_BY,
      style: theme.textTheme.bodyLarge!.copyWith(
        color: AppColors.secondaryColor,
        fontSize: Sizes.TEXT_SIZE_10,
      ),
    ),
  ],
),

      ],
    );
  }

  List<Widget> _buildMenuList({
    required BuildContext context,
    required List<MenuData> menuList,
  }) {
    List<Widget> menuItems = [];
    for (var i = 0; i < menuList.length; i++) {
      menuItems.add(
        MenuItem(
          onTap: () {
            if (menuList[i].title == StringConst.RESUME) {
              Functions.launchUrl(DocumentPath.CV);
            } else if (menuList[i].title == StringConst.CONTACT) {
              Functions.launchUrl(StringConst.EMAIL_URL);
            } else {
              Navigator.of(context).pushNamed(menuList[i].routeName);
            }
          },
          title: menuList[i].title,
          selected:
              selectedItemRouteName == menuList[i].routeName ? true : false,
        ),
      );
      menuItems.add(SpaceH4());
    }
    return menuItems;
  }
}
