import 'package:flutter/material.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_app_bar.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';

class GroupPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupPage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(groupModel: groupModel),
      // body: ,
    );
  }
}
