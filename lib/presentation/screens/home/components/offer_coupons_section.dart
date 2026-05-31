import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alas_mart/logic/cubit/offer_coupons/offer_coupons_cubit.dart';
import 'package:alas_mart/data/models/offer_coupon/offer_coupon_model.dart';

class OfferCouponsSection extends StatelessWidget {
  const OfferCouponsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferCouponsCubit, OfferCouponsState>(
      builder: (context, state) {
        if (state.loading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.error != null) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'حصل خطأ أثناء تحميل الكوبونات',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
        if (state.coupons.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'أحدث الكوبونات',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.coupons.length,
                itemBuilder: (context, index) {
                  final OfferCouponModel c = state.coupons[index];
                  return Container(
                    width: 260,
                    margin: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c.storeName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          c.couponCode,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        if (c.discountValue != null)
                          Text(
                            '${c.discountValue}% خصم',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
