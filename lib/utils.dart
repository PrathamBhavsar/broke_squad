import 'package:flutter/material.dart';
import 'package:logger/web.dart';

getHeight(context) => MediaQuery.sizeOf(context).height;
getWidth(context) => MediaQuery.sizeOf(context).width;

logEvent({required String str}) =>
    Logger(printer: PrettyPrinter(colors: true)).log(Logger.level, str);

logError({required String str, Object? error, StackTrace? stackTrace}) =>
    Logger(printer: PrettyPrinter(colors: true))
        .e(str, stackTrace: stackTrace, time: DateTime.now(), error: error);
