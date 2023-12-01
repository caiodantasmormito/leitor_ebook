import 'package:flutter/material.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_colors.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.iconData,
    this.onPressed,
  });
  final String text;
  final IconData iconData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColors.black,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppTextStyles.mediumText(
                context, FontWeight.bold, AppColors.black),
          ),
        ],
      ),
    );
  }
}
