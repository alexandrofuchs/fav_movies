import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';

class DefaultMainButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool invertColors;
  final Color primaryColor;
  final Color secundaryColor;
  final bool disable;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final OutlinedBorder shape;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Color? iconColor;
  final bool expandedWidth;
  final bool compact;
  final bool boldText;
  final double? width;
  final double minWidth;
  final double maxWidth;

  const DefaultMainButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.minWidth = 120,
      this.maxWidth = 220,
      this.iconColor,
      this.margin = const EdgeInsets.all(8),
      this.padding = const EdgeInsets.all(8),
      this.invertColors = false,
      this.primaryColor = AppColors.primaryColorDark,
      this.secundaryColor = AppColors.secundaryColor,
      this.disable = false,
      this.width,
      this.shape = const RoundedRectangleBorder(
        side: BorderSide(width: 1.5, color: AppColors.primaryColorDark),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      this.leftIcon,
      this.rightIcon,
      this.expandedWidth = false,
      this.compact = false,
      this.boldText = false});

  Color get getPrimaryColor => disable
      ? Colors.grey
      : invertColors
          ? secundaryColor
          : primaryColor;
  Color get getSecundaryColor => invertColors ? primaryColor : secundaryColor;

  Widget labelWidget() =>
      Text(
            label.toUpperCase(),
            overflow: TextOverflow.visible,
            softWrap: true,
            style: AppTextStyles.bodyMedium.copyWith(
                color: getSecundaryColor,
                fontSize: compact ? 8 : 10,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            maxLines: compact ? 1 : null,
  );

  Widget leftIconWidget() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 2),
        child: Icon(
          leftIcon,
          color: iconColor ?? getSecundaryColor,
          size: 24,
        ),
      );

  Widget rightIconWidget() => Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Icon(
        rightIcon,
        color: iconColor ?? getSecundaryColor,
        size: 24,
      ));

  Widget withLeftIcon() => Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: leftIconWidget(),),
            const SizedBox(width: 10),
            Flexible(flex: 3, child: labelWidget(),),
          ],
        ),
  );

  Widget withRightIcon() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          labelWidget(),
          rightIconWidget(),
        ],
      );

  Widget withBothIcons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leftIconWidget(),
          labelWidget(),
          rightIconWidget(),
        ],
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: disable ? null : onPressed,
        child: Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(color: getPrimaryColor, shape: shape),
            height: compact ? 35 : 50,
            constraints: compact
                ? BoxConstraints(
                    maxWidth: maxWidth, minWidth: minWidth, maxHeight: 50)
                : const BoxConstraints(minHeight: 50, maxHeight: 50),
            width: expandedWidth ? MediaQuery.of(context).size.width : width,
            margin: margin,
            padding: compact ? const EdgeInsets.all(2) : padding,
            child: leftIcon == null
                ? rightIcon == null
                    ? labelWidget()
                    : withRightIcon()
                : rightIcon != null
                    ? withBothIcons()
                    : withLeftIcon()),
      );
}
