import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_text_styles.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/controllers/home_controller.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/state/home_state.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/book_list_widget.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/books_and_favorite_switch._widget.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/widgets/favorite_book_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Modular.get<HomeController>();
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    homeController.getBooks();
    homeController.getFavoriteBook();
    pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ebooks",
          style: AppTextStyles.titleText(context),
        ).animate().slide(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BooksAndFavoritesSwitch(
            isBook: currentPage == 0,
            booksOnTap: () async {
              if (pageController.hasClients) {
                setState(() {
                  currentPage = 0;
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.bounceIn);
                });
              }
              await homeController.getBooks();
              await homeController.getFavoriteBook();
            },
            favoritesOnTap: () {
              setState(() {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastEaseInToSlowEaseOut);
                currentPage = 1;
              });
            },
          ),
          ListenableBuilder(
              listenable: homeController,
              builder: (context, _) {
                return switch (homeController.homeState) {
                  InitialHomeState() => Center(
                      child: Text(
                        "Lista vazia",
                        style: AppTextStyles.customStyle(
                            context, FontWeight.w400, 20),
                      ),
                    ),
                  LoadingHomeState() => const Expanded(
                      child: Center(child: CircularProgressIndicator())),
                  (ErrorHomeState error) => Center(
                      child: Text(
                        error.message,
                        style: AppTextStyles.customStyle(
                            context, FontWeight.w400, 15,
                            color: Colors.red),
                      ),
                    ),
                  (GetedBooksHomeState geted) => Expanded(
                      flex: 5,
                      child: PageView(
                        controller: pageController,
                        children: [
                          BookList(
                              geted: geted, homeController: homeController),
                          FavoriteBookList(
                              favoriteBooks: geted.books
                                  .where(
                                      (element) => element.isFavorite == true)
                                  .toList(),
                              homeController: homeController),
                        ],
                      ),
                    )
                };
              })
        ],
      ),
    );
  }
}
