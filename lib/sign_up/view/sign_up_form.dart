import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:proto/sign_up/sign_up.dart';
import 'package:formz/formz.dart';
import 'package:proto/login/login.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.fromLTRB(21, 10, 21, 0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Theme.of(context).backgroundColor,
                  //color: HexColor("#ebf3fb"),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                      child: Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    //const SizedBox(height: 30),
                    _EmailInput(),
                    const SizedBox(height: 8),
                    _PasswordInput(),
                    const SizedBox(height: 8),
                    _ConfirmPasswordInput(),
                    const SizedBox(height: 30),
                    _SignUpButton(),
                    const SizedBox(height: 8),
                    _SignInButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.email_rounded, color: HexColor("#4589d7")),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#4589d7"), width: 1.7),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#23456c"), width: 1.7),
            ),
            labelText: 'email',
            labelStyle: TextStyle(color: HexColor("#4589d7")),
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.password, color: HexColor("#4589d7")),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#4589d7"), width: 1.7),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#23456c"), width: 1.7),
            ),
            labelText: 'password',
            labelStyle: TextStyle(color: HexColor("#4589d7")),
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.password, color: HexColor("#4589d7")),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#4589d7"), width: 1.7),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor("#23456c"), width: 1.7),
            ),
            labelText: 'confirm password',
            labelStyle: TextStyle(color: HexColor("#4589d7")),
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: 280,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).primaryColorDark,
                        Theme.of(context).primaryColorLight,
                      ]),
                ),
                child: TextButton(
                  key: const Key('signUpForm_continue_raisedButton'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ))),
                  onPressed: state.status.isValidated
                      ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                      : null,
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('signUpForm_TextButton'),
      onPressed: () => Navigator.of(context).push<void>(LoginPage.route()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(
                color: Colors.grey.withOpacity(0.8),
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 5),
          Text(
            'Sign in',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
