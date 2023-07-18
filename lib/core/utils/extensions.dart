import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:timeago/timeago.dart';

import '../../main.dart';

extension DioErrorHandler on DioException {
  String handleDioError() {
    String errorDescription = "";
    switch (type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with server";
        break;
      case DioExceptionType.unknown:
        errorDescription =
            "Connection to server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with server";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send Timeout in connection with Server";
        break;
      case DioExceptionType.badResponse:
        errorDescription =
            "Something went wrong and your request could not be completed";
        break;
      case DioExceptionType.connectionError:
        errorDescription =
            "Connection to server failed due to internet connection";
        break;
      case DioExceptionType.badCertificate:
        errorDescription =
            "Something went wrong and your request could not be completed";
        break;
    }
    return errorDescription;
  }
}


extension StringExtensions on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get gif => 'assets/images/$this.gif';
  String get svg => 'assets/vectors/$this.svg';
  SvgPicture svgPicture({double? width, double? height, Color? color}) =>
      SvgPicture.asset(
        'assets/vectors/$this.svg',
        width: width,
        height: height,
        color: color,
      );

  Image pngPicture({double? width, double? height, BoxFit? fit}) => Image.asset(
        'assets/images/$this.png',
        width: width,
        height: height,
        fit: fit,
      );

  String get getGradeName => 'Grade ${substring(1)}';

  CachedNetworkImage cachedNetworkImage(
          {double? width, double? height, BoxFit? fit}) =>
      CachedNetworkImage(
        imageUrl: this,
        width: width,
        height: height,
        placeholder: (context, url) => const LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          // colors: [AppColors.cgsPrimaryButton],
          strokeWidth: 1,
        ).paddingAll(8.r),
        fit: fit ?? BoxFit.cover,
      );

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  Text toText({TextStyle? style, TextAlign? align}) =>
      Text(this, textAlign: align, style: style);

  String get formatParameters => replaceAll(RegExp('_'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

//extension to format timeago
extension DateFormatter on DateTime {
  String get postTimeAgo => format(this);
  String get postDateFormat => DateFormat.MMMd().format(this);
}

extension DurationExtension on int {
  Duration seconds() => Duration(seconds: this);
  Duration milliseconds() => Duration(milliseconds: this);
  Duration minutes() => Duration(minutes: this);
  Duration hours() => Duration(hours: this);
  Duration days() => Duration(days: this);
  Duration weeks() => Duration(days: this * 7);
  Duration months() => Duration(days: (this * 365 / 12).round());
  Duration years() => Duration(days: this * 365);
}

extension ContextExtension on BuildContext {
  showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  Future showDialog(String title, String message) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: this,
        builder: (context) => CupertinoAlertDialog(
          title: title.toText(),
          content: message.toText(),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: 'OK'.toText(
                style: context.labelSmall!.copyWith(
                  // color: AppColors.cgsPrimaryButton,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return showGeneralDialog(
        context: this,
        barrierDismissible: true,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation1, animation2) {
          return AlertDialog(
            title: title.toText(
                style: context.labelLarge!.copyWith(
              color: darkTheme.value ? Colors.white : Colors.black,
            )),
            content: message.toText(style: context.labelSmall),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: 'OK'.toText(
                  style: context.labelSmall!.copyWith(
                    // color: AppColors.cgsPrimaryButton,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
