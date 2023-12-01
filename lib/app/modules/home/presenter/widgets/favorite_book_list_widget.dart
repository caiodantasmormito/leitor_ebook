import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_text_styles.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/controllers/home_controller.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/book_widget.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/custom_button.dart';

class FavoriteBookList extends StatelessWidget {
  const FavoriteBookList({
    super.key,
    required this.favoriteBooks,
    required this.homeController,
  });

  final List<BookModel> favoriteBooks;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return favoriteBooks.isEmpty
        ? Center(
            child: Text(
              "Lista vazia",
              style: AppTextStyles.customStyle(context, FontWeight.w400, 20),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Wrap(
                children: favoriteBooks
                    .map((e) => BookWidget(
                          book: e,
                          onTapBook: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, top: 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: e.coverUrl,
                                              height: 300,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              e.title,
                                              style: AppTextStyles.mediumText(
                                                  context),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              e.author,
                                              style: AppTextStyles.smallText(
                                                  context),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomButton(
                                                  text: "Ler",
                                                  iconData: Icons.play_arrow,
                                                  onPressed: () async =>
                                                      homeController
                                                          .readBook(e),
                                                ),
                                                const SizedBox(width: 16),
                                                CustomButton(
                                                  text: "Baixar",
                                                  iconData: Icons.download,
                                                  onPressed: () {
                                                    homeController
                                                        .downloadBook(e);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          onTapFavorite: () =>
                              homeController.setFavoriteBook(e, !e.isFavorite!),
                        ).animate().flip(perspective: -0.5, begin: 0.3).fade())
                    .toList(),
              ),
            ),
          );
  }
}
