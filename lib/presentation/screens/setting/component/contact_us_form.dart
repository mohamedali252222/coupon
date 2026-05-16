import 'package:alas_mart/logic/cubit/contact_us/contact_us_cubit.dart';
import 'package:alas_mart/logic/cubit/contact_us/contact_us_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/error_text.dart';
import '../../../widget/primary_button.dart';

class ContactUsForm extends StatelessWidget {
  const ContactUsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final contactUsCubit = context.read<ContactUsCubit>();
    return BlocListener<ContactUsCubit, ContactUsStateModel>(
      listener: (context, state) {
        final contact = state.contactUsState;
        if (contact is ContactUsMessageLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (contact is ContactUsMessageError) {
            Utils.errorSnackBar(context, contact.message);
          } else if (contact is ContactUsMessageLoad) {
            Navigator.pop(context);
            //contactUsCubit.clear();
            Utils.showSnackBar(context, contact.message);
          }
        }
      },
      child: Column(
        children: [
          CustomFormWidget(
            label: 'Your Name',
            bottomSpace: 16.0,
            child: BlocBuilder<ContactUsCubit, ContactUsStateModel>(
              builder: (context, state) {
                final s = state.contactUsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'your name'),
                      keyboardType: TextInputType.name,
                      onChanged: (String name) =>
                          contactUsCubit.nameChange(name),
                      initialValue: state.name,
                    ),
                    if (s is ContactUsMessageFormValidate) ...[
                      if (s.errors.name.isNotEmpty)
                        ErrorText(text: s.errors.name.first)
                    ]
                  ],
                );
              },
            ),
          ),
          CustomFormWidget(
            label: 'Email Address',
            bottomSpace: 16.0,
            child: BlocBuilder<ContactUsCubit, ContactUsStateModel>(
              builder: (context, state) {
                final s = state.contactUsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'your email'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String name) =>
                          contactUsCubit.emailChange(name),
                      initialValue: state.email,
                    ),
                    if (s is ContactUsMessageFormValidate) ...[
                      if (s.errors.email.isNotEmpty)
                        ErrorText(text: s.errors.email.first)
                    ]
                  ],
                );
              },
            ),
          ),
          CustomFormWidget(
            label: 'Phone Number',
            bottomSpace: 16.0,
            child: BlocBuilder<ContactUsCubit, ContactUsStateModel>(
              builder: (context, state) {
                final s = state.contactUsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'phone number'),
                      keyboardType: TextInputType.phone,
                      onChanged: (String name) =>
                          contactUsCubit.phoneChange(name),
                      initialValue: state.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny('a'),
                      ],
                    ),
                    if (s is ContactUsMessageFormValidate) ...[
                      if (s.errors.phone.isNotEmpty)
                        ErrorText(text: s.errors.phone.first)
                    ]
                  ],
                );
              },
            ),
          ),
          CustomFormWidget(
            label: 'Subject',
            bottomSpace: 16.0,
            child: BlocBuilder<ContactUsCubit, ContactUsStateModel>(
              builder: (context, state) {
                final s = state.contactUsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'subject'),
                      keyboardType: TextInputType.text,
                      onChanged: (String name) =>
                          contactUsCubit.subjectChange(name),
                      initialValue: state.subject,
                    ),
                    if (s is ContactUsMessageFormValidate) ...[
                      if (s.errors.subject.isNotEmpty)
                        ErrorText(text: s.errors.subject.first)
                    ]
                  ],
                );
              },
            ),
          ),
          CustomFormWidget(
            label: 'Message',
            bottomSpace: 30.0,
            child: BlocBuilder<ContactUsCubit, ContactUsStateModel>(
              builder: (context, state) {
                final s = state.contactUsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'message'),
                      keyboardType: TextInputType.multiline,
                      onChanged: (String name) =>
                          contactUsCubit.messageChange(name),
                      initialValue: state.message,
                      maxLines: 4,
                    ),
                    if (s is ContactUsMessageFormValidate) ...[
                      if (s.errors.message.isNotEmpty)
                        ErrorText(text: s.errors.message.first)
                    ]
                  ],
                );
              },
            ),
          ),
          PrimaryButton(
              text: 'Send Now',
              onPressed: () {
                Utils.closeKeyBoard(context);
                contactUsCubit.sendContactUsMessage();
              }),
        ],
      ),
    );
  }
}
