import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/bottom_titles.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile({
    super.key,
    required this.text,
    required this.text2,
    this.onExpansionChanged,
    this.trailing,
    required this.children,
  });

  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: AppConst.lightBk,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConst.radius),
      ),
      child: ExpansionTile(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConst.radius),
        ),
        title: BottomTitles(
          text: text,
          text2: text2,
        ),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.trailing,
        onExpansionChanged: onExpansionChanged,
        trailing: trailing,
        children: children,
      ),
    );
  }
}
