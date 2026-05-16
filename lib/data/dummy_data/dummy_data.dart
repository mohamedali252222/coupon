import '../../presentation/utils/k_images.dart';

class DummyProductType {
  final int id;
  final String title;

  const DummyProductType({
    required this.id,
    required this.title,
  });
}

final List<DummyProductType> types = [
  const DummyProductType(id: 1, title: 'Image'),
  const DummyProductType(id: 2, title: 'Video'),
  const DummyProductType(id: 3, title: 'Audio'),
  const DummyProductType(id: 4, title: 'PHP Script'),
  const DummyProductType(id: 5, title: 'Wordpress'),
  const DummyProductType(id: 6, title: 'WP Theme'),
];

final List<DummyProductType> payments = [
  const DummyProductType(id: 1, title: 'Bank'),
  const DummyProductType(id: 2, title: 'Cash on Delivery'),
  const DummyProductType(id: 3, title: 'Bank Transfer'),
];

final List<DummyProductType> countries = [
  const DummyProductType(id: 1, title: 'Afghanistan'),
  const DummyProductType(id: 2, title: 'Albania'),
  const DummyProductType(id: 3, title: 'Algeria'),
  const DummyProductType(id: 4, title: 'Bangladesh'),
  const DummyProductType(id: 5, title: 'Pakistan'),
  const DummyProductType(id: 6, title: 'India'),
  const DummyProductType(id: 7, title: 'USA'),
];

final List<String> catImages = [
  KImages.html,
  KImages.uiux,
  KImages.wordpress,
  KImages.image_sells,
  KImages.wwp_plugin,
  KImages.appDesign,
];
final List<String> catTitles = [
  'Html',
  'UiUx',
  'Wordpress',
  'Image ',
  'UiUx ',
  'App Design',
];

const String offerText =
    'Check our software Megapack worth \$565 for Only \$39.';

const String offerText2 = 'Sell your Products with Our Digital Marketplace';

String description =
    "A great way to start is by browsing through our categories to see what other authors are selling.";

const String term1 =
    'The User must undertake to adhere to the eligibility to enter into a contract in view of section 11 of The Indian Contract Act, 1872. The User shall agree to represent and warrant that the User is at the age of 18';
const String term2 =
    'A user shall not be entitled to cancel any order after it has been confirmed by the merchant. Any cancellation made after the confirmation shall be subject to a cancellation fee up to the amount of order placed. Such cancellation fee shall be updated in the App in the outstanding section and the user before placing the next order shall clear such outstanding.';
const String term3 =
    'The FDP shall make it clear that it is not either a manufacturer or a seller or distributor of food or beverages but only places an order against the partner restaurant on behalf of the User customer pursuant';
const String term4 =
    'The event the User commits anAuthorization Breach, the User shall be liable to pay the liquidated damages of an amount equivalent to the Order Value. The User must undertake to authorize FDP to deduct or collect the amount payable as liquidating damages through such means as Food Delivery Platform may determinen in its discretion, including without limitation, by deducting such amount from the payment made towards User’s next order.';
const String paymentCondition =
    'The user shall be entitled to a refund only if following circumstances:';
const String subCon1 =
    'The order packaging has been tampered or damaged at the time of delivery';
const String subCon2 =
    'Your delivery location following outside our designated delivery zones';
const String subCon3 =
    'All refund amounts shall be credited to your account within 3-4 business days in accordance with the terms that may be stipulated by the bank which has issued the credit/debit card.';

const String aboutMe =
    '''Hello, I’m John Doe./p pUI, UX, Frontend Development, Backend Development and much more.../p pPHP, HTML5, CSS3, jQuery, Web Design, UI - UX Design./p pI have been working as a freelancer for more than 10 years. And I have experience at this level as well. If you have special requests, you can contact me by e-mail. I can do what you want in a short time and deliver it in a very clean way./p pMail: Demoemail@mail.com/p pYou can contact me faster on Instagram. If you follow and send a message, I will respond to messages within 30 minutes. If you don't follow me, I won't see the message because it goes to your other folder./p pContact me on Instagram!/p pThank you.''';
const skillDes =
    "This is one of the best WordPress Theme. It is clean, user friendly, fully responsive, pixel perfect, modern design with latest WordPress Technologie Fully Responsive Bootstrap Based (3.x) Latest";
const String aboutUs =
    '''Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubted source. Lorem Ipsum comes from sections ''';

final skills = [
  "Clean, Modern & Beautiful Design",
  "Unique Header Style",
  "liElementor Page Builder",
  "Footer Copyright Style",
  "100% Valid Code" "3000+ Font Icon",
  "One Click Demo Import",
  "Powerful Options Panel"
];

class DummyThemeModel {
  final String image;
  final String name;
  final String category;
  final int price;
  final int rating;
  final int download;

  DummyThemeModel({
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.download,
    required this.rating,
  });
}

const String title = 'Oifolio-Digital Marketing\nAgency Theme';
const String cat = 'Wordpress';
const int download = 2;
const int rating = 4;
const int price = 69;
const String largeImage = 'assets/product_image/wp12.png';

final List<DummyThemeModel> themes = [
  DummyThemeModel(
      image: 'assets/product_image/wp01.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp02.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp03.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp04.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp05.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp06.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp07.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp08.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp03.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
  DummyThemeModel(
      image: 'assets/product_image/wp05.png',
      name: title,
      category: cat,
      price: price,
      download: download,
      rating: rating),
];

class DummyComment {
  final String name;
  final String comment;
  final String image;
  final String time;

  const DummyComment({
    required this.name,
    required this.comment,
    required this.image,
    required this.time,
  });
}

final List<DummyComment> comments = [
  const DummyComment(
      name: 'Liubov Melnikova',
      comment:
          "When I generate one dummy text it returns only one line. I wish that I can choose many text instead of one line.",
      image: KImages.userPicture,
      time: '2 days ago'),
  const DummyComment(
      name: 'Raphael Parree',
      comment:
          'Love this plugin! Does exactly what it is supposed to do and so far without any real issues.',
      image: KImages.userPicture,
      time: '30 days ago'),
  const DummyComment(
      name: 'Liubov Melnikova',
      comment:
          "Well, seems like a nice plugin and all, but it doesn't work on mac.. Or atleast, I can't get it to work",
      image: KImages.userPicture,
      time: '1 min ago'),
  const DummyComment(
      name: 'Kay Stenschke',
      comment:
          "Really nice idea, this adds a little flavor to all those dummy-texts! I can recommend setting up keystrokes for this, it'll speed up the process a lot!",
      image: KImages.userPicture,
      time: 'Just now'),
  const DummyComment(
      name: 'Kay Stenschke',
      comment:
          "Raphael, thanks for your feedback and great idea! With version 1.0.3 you'll find the plugin available as generator options as well.",
      image: KImages.userPicture,
      time: '1 week ago'),
  const DummyComment(
      name: 'Raphael Parree',
      comment:
          "I love this plugin. Thanks. Some improvements: Make it available under alt+insert (generate) Make it easier",
      image: KImages.userPicture,
      time: '1 year ago'),
];

List<String> featureText = [
  'Clean, Modern & Beautiful Design',
  '4 Unique Header Style',
  '100% Valid Code',
  '3000+ Font Icon',
  'One Click Demo Import',
];
final List<String> fileText = [
  'WordPress Theme Files',
  'Dummy Content',
  'Online Documentation Link',
];
final List<String> imageText = [
  'Pixabay',
  'Unsplash',
  'Freepik',
];

class DummyExpertise {
  final String name;
  final String image;
  final String designation;

  const DummyExpertise({
    required this.name,
    required this.designation,
    required this.image,
  });
}

final List<DummyExpertise> expertise = [
  const DummyExpertise(
      name: 'Jimmy Griffith',
      image: KImages.userPicture,
      designation: 'UIUX Designer'),
  const DummyExpertise(
      name: 'Jack Mckenzie',
      image: KImages.userPicture,
      designation: 'App Developer'),
  const DummyExpertise(
      name: 'Tomas Collier',
      image: KImages.userPicture,
      designation: 'Flutter Dev'),
  const DummyExpertise(
      name: 'Marjorie Doyle',
      image: KImages.userPicture,
      designation: 'Laravel Developer'),
  const DummyExpertise(
      name: 'Louise Wells',
      image: KImages.userPicture,
      designation: 'React JS Ddev'),
  // const DummyExpertise(name: 'Angelica Chavez', image: KImages.userPicture, designation: ''),
  // const DummyExpertise(name: 'Shawn Mcdaniel', image: KImages.userPicture, designation: ''),
  // const DummyExpertise(name: 'Bill Howell', image: KImages.userPicture, designation: ''),
];
