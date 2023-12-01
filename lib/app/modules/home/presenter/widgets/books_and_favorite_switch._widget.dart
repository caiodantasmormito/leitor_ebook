import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_colors.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_text_styles.dart';

class BooksAndFavoritesSwitch extends StatelessWidget {
  const BooksAndFavoritesSwitch({
    super.key,
    this.booksOnTap,
    this.favoritesOnTap,
    required this.isBook,
  });
  final void Function()? booksOnTap;
  final void Function()? favoritesOnTap;
  final bool isBook;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 25, left: 20),
        height: 45,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchItem(
              name: "Livros",
              isActivated: isBook,
              onTap: booksOnTap,
            ),
            const SizedBox(width: 6,),
            SwitchItem(
              name: "Favoritos",
              isActivated: !isBook,
              onTap: favoritesOnTap,
            )
          ],
        ),
      ).animate().slideX(),
    );
  }
}

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    super.key,
    required this.name,
    this.onTap,
    required this.isActivated,
  });
  final String name;
  final void Function()? onTap;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      child: Card(
        elevation: isActivated ? 2 : 0,
        margin: EdgeInsets.zero,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.darkGrey),
              boxShadow: !isActivated
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.10),
                        blurRadius: 0.2,
                      ),
                    ]
                  : [BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        blurRadius: 0.2,
                      ),],),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Text(name,
                  style: AppTextStyles.mediumText(context,
                      isActivated ? FontWeight.w800 : FontWeight.w300)),
            ),
          ),
        ),
      ),
    );
  }
}
