import 'package:flutter/material.dart';

//主题色调
final Color APP_ThemeColor = Color.fromRGBO(223, 223, 223, 1.0);
//屏幕的宽 等同于 [UIScreen mainScreen].bounds.size.width 因为这里需要一个context 所以需要定义成方法
double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
//屏幕的高
double ScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

