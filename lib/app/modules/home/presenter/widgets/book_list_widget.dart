import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_text_styles.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/controllers/home_controller.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/state/home_state.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/book_widget.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/custom_button.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.geted,
    required this.homeController,
  });

  final GetedBooksHomeState geted;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
    child: Wrap(
      children: geted.books
          .map((e) => BookWidget(
                book: e,
                onTapBook: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, top: 8),
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
                                    style:
                                        AppTextStyles.mediumText(context),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    e.author,
                                    style: AppTextStyles.smallText(context),
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
                                            homeController.readBook(e),
                                      ),
                                      const SizedBox(width: 16),
                                      CustomButton(
                                        text: "Baixar",
                                        iconData: Icons.download,
                                        onPressed: () {
                                          homeController.downloadBook(e);
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
