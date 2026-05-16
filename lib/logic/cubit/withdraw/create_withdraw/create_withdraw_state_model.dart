import 'package:equatable/equatable.dart';

import 'create_withdraw_cubit.dart';

class CreateWithdrawStateModel extends Equatable {
  final String methodId;
  final String withdrawAmount;
  final String accountInfo;
  final String languageCode;
  final CreateWithdrawState withdrawState;

  const CreateWithdrawStateModel({
    this.methodId = '',
    this.withdrawAmount = '',
    this.accountInfo = '',
    this.languageCode = '',
    this.withdrawState = const CreateWithdrawInitial(),
  });

  CreateWithdrawStateModel copyWith({
    String? methodId,
    String? withdrawAmount,
    String? accountInfo,
    String? languageCode,
    CreateWithdrawState? withdrawState,
  }) {
    return CreateWithdrawStateModel(
      methodId: methodId ?? this.methodId,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      accountInfo: accountInfo ?? this.accountInfo,
      languageCode: languageCode ?? this.languageCode,
      withdrawState: withdrawState ?? this.withdrawState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'method_id': methodId,
      'withdraw_amount': withdrawAmount,
      'lang_code': languageCode,
      'account_info': accountInfo,
    };
  }

  CreateWithdrawStateModel clear() {
    return const CreateWithdrawStateModel(
      methodId: '',
      withdrawAmount: '',
      accountInfo: '',
      // languageCode: '',
      withdrawState: CreateWithdrawInitial(),
    );
  }

  @override
  List<Object> get props => [
        methodId,
        withdrawAmount,
        accountInfo,
        languageCode,
        withdrawState,
      ];
}
