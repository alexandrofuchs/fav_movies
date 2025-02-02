import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/snackbars/app_snackbars.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_review/movie_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieReviewWidget on CommonWidgets {
  final ValueNotifier<int> rate = ValueNotifier(0);
  final TextEditingController description = TextEditingController();
  final reviewBloc = MovieReviewBloc(Modular.get());

  Widget _movieInfo(Movie movie) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Text(
              movie.title,
              style: AppTextStyles.labelMedium,
            ),
          ],
        ),
      );

  Widget rateWidget() => ValueListenableBuilder(
        valueListenable: rate,
        builder: (context, value, child) => _rateWidget(value),
      );

  Widget showRateWidget({bool enable = true, bool showDescription = false}) =>
      Column(
        children: [
          BlocBuilder<MovieReviewBloc, MovieReviewBlocState>(
              bloc: reviewBloc,
              buildWhen: (previous, current) =>
                  current.status == MovieReviewBlocStatus.loaded,
              builder: (context, state) => switch (state.status) {
                    MovieReviewBlocStatus.initial => const SizedBox(),
                    MovieReviewBlocStatus.loading => const SizedBox(),
                    MovieReviewBlocStatus.failed => const SizedBox(),
                    MovieReviewBlocStatus.loaded => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rateWidget(state.movieReview!.rate),
                            showDescription
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 30, right: 30),
                                    child: infoRow('Opinião: ',
                                        state.movieReview!.description),
                                  )
                                : const SizedBox(),
                            divider(),
                          ],
                        ),
                      ),
                  }),
        ],
      );

  Widget _rateWidget(int value, {bool enable = true}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: titleDot('Sua avaliação'),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4, 5]
                  .map((e) => Flexible(
                        child: IconButton(
                            enableFeedback: enable,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (!enable) return;
                              rate.value = e;
                            },
                            icon: Icon(
                              e <= value ? Icons.star : Icons.star_border,
                              size: 24,
                              color: AppColors.orangeColor,
                            )),
                      ))
                  .toList()),
        ],
      );

  Widget _descriptionWidget() => Padding(
        padding: const EdgeInsets.all(15),
        child: TextField(
          style: AppTextStyles.labelSmall,
          decoration: const InputDecoration(
            fillColor: AppColors.brandColor,
            filled: true,
            labelStyle: AppTextStyles.labelSmall,
            label: Text(
              'Descreva sua opinião',
              style: AppTextStyles.labelSmall,
              textAlign: TextAlign.center,
            ),
            alignLabelWithHint: true,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orangeColor)),
            contentPadding: EdgeInsets.all(15),
            counterStyle: AppTextStyles.labelSmall,
          ),
          controller: description,
          maxLines: 5,
          maxLength: 200,
        ),
      );

  Widget reviewedListener({Widget? child}) =>
      BlocListener<MovieReviewBloc, MovieReviewBlocState>(
        bloc: reviewBloc,
        listenWhen: (previous, current) =>
            current.status == MovieReviewBlocStatus.loaded,
        listener: (context, state) {
          AppSnackbars.showSuccessSnackbar(context, "Avaliação salva");

          Modular.to.pop();
        },
        child: child,
      );

  Widget _actionsWidget(BuildContext context, Movie movie) => Row(
        children: [
          Flexible(
              child: DefaultMainButton(
                  invertColors: true,
                  primaryColor: AppColors.orangeColor,
                  label: 'Cancelar',
                  onPressed: () {
                    Modular.to.pop();
                  })),
          Flexible(
              child: DefaultMainButton(
                  label: 'Confirmar',
                  primaryColor: AppColors.orangeColor,
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
                  })),
        ],
      );

  Future<void> openReviewBottomSheet(BuildContext context, Movie movie) async {
    rate.value = 0;
    description.text = '';

    await showModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        body: reviewedListener(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primaryColorDark,
            ),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    _movieInfo(movie),
                    rateWidget(),
                    _descriptionWidget(),
                    _actionsWidget(context, movie),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
