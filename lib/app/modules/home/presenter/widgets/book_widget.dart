import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_colors.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_text_styles.dart';
import 'package:leitor_de_ebooks/app/core/utils/dynamic_responsive_size.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';
import 'package:shimmer/shimmer.dart';

class BookWidget extends StatelessWidget {
  const BookWidget(
      {super.key, required this.book, this.onTapFavorite, this.onTapBook});
  final BookModel book;
  final void Function()? onTapFavorite;
  final void Function()? onTapBook;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DynamicResponsiveSize.of(context).dynamicScaleSize(size: 300),
      width: DynamicResponsiveSize.of(context).dynamicScaleSize(size: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTapBook,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: book.coverUrl,
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, string) => SizedBox(
                      width: 100,
                      height: 150,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white60,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: -4,
                    right: -5,
                    child: GestureDetector(
                      onTap: onTapFavorite,
                      child: Icon(
                        book.isFavorite == true
                            ? Icons.bookmark_outlined
                            : Icons.bookmark_outline_rounded,
                        size: 35,
                        color: book.isFavorite == true ? AppColors.red : null,
                      ),
                    )),
              ]),
            ),
          ),
          Text(
            book.title,
            style: AppTextStyles.mediumText(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            book.author,
            style: AppTextStyles.smallText(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
