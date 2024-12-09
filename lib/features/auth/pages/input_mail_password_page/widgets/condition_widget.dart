import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/utils/bool_value_enum.dart';

class ConditionWidget extends StatelessWidget {
  const ConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueStateProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Visibility(
          visible: !provider.isSignIn,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  provider.changeBoolValue(BoolValueEnum.agreeCondition);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(),
                  ),
                  child: provider.agreeCondition
                      ? const Icon(Icons.done)
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'I agree to the terms & conditions',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF243443),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
