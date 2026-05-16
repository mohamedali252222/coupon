part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();

  @override
  List<Object> get props => [];
}

class DashboardUserPortfolioLoading extends DashboardState {}

class DashboardUserPortfolioLoaded extends DashboardState {
  final SearchResponseModel portfolio;

  const DashboardUserPortfolioLoaded(this.portfolio);

  @override
  List<Object> get props => [portfolio];
}

class DashboardUserPortfolioError extends DashboardState {
  final String message;
  final int statusCode;

  const DashboardUserPortfolioError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class DashboardProductDeleting extends DashboardState {}

class DashboardProductDeleted extends DashboardState {
  final String message;

  const DashboardProductDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class DashboardDeleteProductError extends DashboardState {
  final String message;
  final int statusCode;

  const DashboardDeleteProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
