import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/snackbars/app_snackbars.dart';
import 'package:fav_movies/core/widgets/text_fields/default_text_field.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_review/movie_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieReviewWidget {
  final ValueNotifier<int> rate = ValueNotifier(0);
  final TextEditingController description = TextEditingController();
  final reviewBloc = MovieReviewBloc(Modular.get());

  Widget _header() => Container(
        alignment: Alignment.center,
        height: 75,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
        child: Text(
          'Avaliar',
          style: AppTextStyles.titleLarge
              .copyWith(color: AppColors.secundaryColor),
        ),
      );

  Widget _movieInfo(Movie movie) => Column(
        children: [
          RichText(
            text: TextSpan(
              style: AppTextStyles.bodyMedium,
              children: <TextSpan>[
                const TextSpan(
                    text: 'Filme: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: movie.title),
              ],
            ),
          )
        ],
      );

  Widget rateWidget() => ValueListenableBuilder(
        valueListenable: rate,
        builder: (context, value, child) => _rateWidget(value),
      );

  Widget showRateWidget([bool enable = true]) =>
      BlocBuilder<MovieReviewBloc, MovieReviewBlocState>(
          bloc: reviewBloc,
          buildWhen: (previous, current) =>
              current.status == MovieReviewBlocStatus.loaded,
          builder: (context, state) => switch (state.status) {
                MovieReviewBlocStatus.initial => const SizedBox(),
                MovieReviewBlocStatus.loading => const SizedBox(),
                MovieReviewBlocStatus.failed => const SizedBox(),
                MovieReviewBlocStatus.loaded =>
                  _rateWidget(state.movieReview!.rate),
              });

  Widget _rateWidget(int value, [bool enable = true]) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [1, 2, 3, 4, 5]
          .map((e) => IconButton(
              enableFeedback: enable,
              onPressed: () {
                if (!enable) return;
                rate.value = e;
              },
              icon: Icon(
                e <= value ? Icons.star : Icons.star_border,
                size: 24,
              )))
          .toList());

  Widget _descriptionWidget() => DefaultTextField(
        controller: description,
        maxLines: 5,
        maxLength: 200,
      );

  Widget _actionsWidget(BuildContext context, Movie movie) => Row(
        children: [
          Flexible(
              child: DefaultMainButton(
                  invertColors: true, label: 'Cancelar', onPressed: () {})),
          Flexible(
              child: DefaultMainButton(
                  label: 'Confirmar',
                  onPressed: () {
                    if (rate.value == 0) {
                      AppSnackbars.showErrorSnackbar(
                          context, 'Selecione uma nota pressionando a estrela');
                      return;
                    }

                    if (description.text.isEmpty) {
                      AppSnackbars.showErrorSnackbar(
                          context, 'Digite sua opinião');
                      return;
                    }

                    reviewBloc.add(SaveReviewEvent(MovieReview(
                        movieId: movie.id,
                        rate: rate.value,
                        description: description.text)));

                    Modular.to.pop();
                  })),
        ],
      );

  Future<void> openReviewBottomSheet(BuildContext context, Movie movie) async {
    rate.value = 0;
    description.text = '';

    await showModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: AppColors.secundaryColor,
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(15),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Column(
              children: [
                _header(),
                _movieInfo(movie),
                rateWidget(),
                _descriptionWidget(),
                _actionsWidget(context, movie),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
