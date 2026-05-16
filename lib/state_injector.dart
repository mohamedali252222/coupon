import 'package:alas_mart/logic/cubit/currency/currency_cubit.dart';
import 'package:http/http.dart';

import 'logic/cubit/change_password/change_password_cubit.dart';
import 'logic/cubit/update/update_cubit.dart';
import 'state_packages_name.dart';

class StateInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final repositoryProviders = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),

    ///data source repository
    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(
        client: context.read(),
      ),
    ),

    RepositoryProvider<LocalDataSource>(
      create: (context) => LocalDataSourceImpl(
        sharedPreferences: context.read(),
      ),
    ),
    RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    RepositoryProvider<WebsiteSetupRepository>(
      create: (context) => WebsiteSetupRepositoryImpl(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    RepositoryProvider<HomeRepository>(
      create: (context) => HomeRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<ProfileRepository>(
      create: (context) => ProfileRepositoryImp(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),
    RepositoryProvider<WishListRepository>(
      create: (context) => WishListRepositoryImp(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    RepositoryProvider<DetailsRepository>(
      create: (context) => DetailsRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<GeneralRepository>(
      create: (context) => GeneralRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<SearchRepository>(
      create: (context) => SearchRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<CartRepository>(
      create: (context) => CartRepositoryImpl(
        remoteDataSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    RepositoryProvider<DownloadRepository>(
      create: (context) => DownloadRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<WithdrawRepository>(
      create: (context) => WithdrawRepositoryImpl(
        remoteDataSources: context.read(),
      ),
    ),
    RepositoryProvider<UploadProductRepository>(
      create: (context) => UploadProductRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),

    RepositoryProvider<DashboardRepository>(
      create: (context) => DashboardRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(
      create: (context) => InternetStatusBloc(),
    ),

    BlocProvider<CurrencyCubit>(
      create: (context) => CurrencyCubit(),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: context.read(),
      ),
    ),

    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        authRepository: context.read(),
      ),
    ),
    BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(
        authRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<WebsiteSetupCubit>(
      create: (context) => WebsiteSetupCubit(
        repository: context.read(),
      ),
    ),
    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        homeRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        loginBloc: context.read(),
        repository: context.read(),
      ),
    ),
    // BlocProvider<ProfileUpdateBloc>(
    //   create: (context) => ProfileUpdateBloc(
    //     loginBloc: context.read(),
    //     profileRepository: context.read(),
    //   ),
    // ),
    BlocProvider<ChangePasswordCubit>(
      create: (context) => ChangePasswordCubit(
        loginBloc: context.read(),
        profileRepository: context.read(),
      ),
    ),
    BlocProvider<WishlistCubit>(
      create: (context) => WishlistCubit(
        loginBloc: context.read(),
        wishlistRepository: context.read(),
      ),
    ),
    // BlocProvider<WishlistUpdateCubit>(
    //   create: (context) => WishlistUpdateCubit(
    //     loginBloc: context.read(),
    //     wishListRepository: context.read(),
    //   ),
    // ),
    BlocProvider<ContactUsCubit>(
      create: (context) => ContactUsCubit(
        contactUsRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<AboutUsCubit>(
      create: (context) => AboutUsCubit(
        contactUsRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<PrivacyPolicyCubit>(
      create: (context) => PrivacyPolicyCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    // BlocProvider<ContactUsCubit>(
    //     create: (context) => ContactUsCubit(
    //           contactUsRepository: context.read(),
    //         )),
    // BlocProvider<CategoryCubit>(
    //   create: (context) => CategoryCubit(
    //     homeRepository: context.read(),
    //   ),
    // ),
    BlocProvider<DetailsCubit>(
      create: (context) => DetailsCubit(
        detailsRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        searchRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CartCubit>(
      create: (context) => CartCubit(
        cartRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<AddToCartCubit>(
      create: (context) => AddToCartCubit(
        cartRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UploadProductBloc>(
      create: (context) => UploadProductBloc(
        productRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<UpdateCubit>(
      create: (context) => UpdateCubit(
        productRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<VariantCubit>(
      create: (context) => VariantCubit(
        productRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(
        dashboardRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<FilterCubit>(
      create: (context) => FilterCubit(
        repository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<PaymentCubit>(
      create: (context) => PaymentCubit(
        cartRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SellerWithdrawCubit>(
      create: (context) => SellerWithdrawCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<CreateWithdrawCubit>(
      create: (context) => CreateWithdrawCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<SingleAccountInfoCubit>(
      create: (context) => SingleAccountInfoCubit(
        withdrawRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    // BlocProvider<CountryStateByIdCubit>(
    //   create: (context) => CountryStateByIdCubit(
    //     profileRepository: context.read(),
    //     loginBloc: context.read(),
    //   ),
    // ),
    BlocProvider<DownloadCubit>(
      create: (context) => DownloadCubit(
        downloadRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
    BlocProvider<StripePaymentCubit>(
      create: (context) => StripePaymentCubit(
        paymentRepository: context.read(),
        loginBloc: context.read(),
      ),
    ),
  ];
}
