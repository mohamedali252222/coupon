import 'package:equatable/equatable.dart';

import '../../../utils/k_images.dart';

class OnBoardingData extends Equatable {
  final String image;
  final String title;
  final String subTitle;

  const OnBoardingData({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  List<Object?> get props => [
        image,
        title,
        subTitle,
      ];
}

final List<OnBoardingData> data = [
  const OnBoardingData(
    image: KImages.onBoarding01,
    title: 'Buy Great\nQuality Theme & Plugin',
    subTitle:
        'Curates the best new blockchain jobs at leading companies that use blockchain technology',
  ),
  const OnBoardingData(
    image: KImages.onBoarding02,
    title: 'Income Money More than\nMany Country',
    subTitle:
        'Curates the best new blockchain jobs at leading companies that use blockchain technology',
  ),
  const OnBoardingData(
    image: KImages.onBoarding03,
    title: 'Make lots of Amazing\nwebsite, Plugin',
    subTitle:
        'Curates the best new blockchain jobs at leading companies that use blockchain technology',
  ),
];
