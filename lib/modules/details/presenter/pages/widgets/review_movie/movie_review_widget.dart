import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/snackbars/app_snackbars.dart';
import 'package:fav_movies/core/widgets/text_fields/default_text_field.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_review/movie_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieReviewWidget on CommonWidgets {
  final ValueNotifier<int> rate = ValueNotifier(0);
  final TextEditingController description = TextEditingController();
  final reviewBloc = MovieReviewBloc(Modular.get());

  Widget _header() => Container(
        alignment: Alignment.center,
        height: 75,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Text(
          'Avaliar',
          style: AppTextStyles.titleLarge
              .copyWith(color: AppColors.secundaryColor),
        ),
      );

  Widget _movieInfo(Movie movie) => Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
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
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.secundaryColor),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rateWidget(state.movieReview!.rate),
                            showDescription
                                ? Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: infoRow('Opinião: ',
                                        state.movieReview!.description),
                                  )
                                : const SizedBox()
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
            padding: const EdgeInsets.only(left: 25, top: 15),
            child: Text(
              'Sua avaliação',
              style: AppTextStyles.titleSmall
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4, 5]
                  .map((e) => Flexible(
                        child: IconButton(
                            enableFeedback: enable,
                            onPressed: () {
                              if (!enable) return;
                              rate.value = e;
                            },
                            icon: Icon(
                              e <= value ? Icons.star : Icons.star_border,
                              size: 32,
                            )),
                      ))
                  .toList()),
        ],
      );

  Widget _descriptionWidget() => Padding(
        padding: const EdgeInsets.all(15),
        child: DefaultTextField(
          labelText: 'Deixe sua opinião',
          labelColor: Colors.black,
          fillColor: Colors.white,
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
                  label: 'Cancelar',
                  onPressed: () {
                    Modular.to.pop();
                  })),
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
              color: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                _header(),
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
