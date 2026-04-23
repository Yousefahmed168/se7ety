import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/specialization_data.dart';

const Color skyBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);

const Color orange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);

const Color purple = Color(0xff8873f4);
const Color purpleLight = Color(0xff9489f4);

const Color green = Color(0xff4cd1bc);
const Color lightGreen = Color(0xff5ed6c3);

class CardModel {
  String specialization;
  Color cardBackground;
  Color cardLightColor;

  CardModel(this.specialization, this.cardBackground, this.cardLightColor);
}

List<CardModel> cards = [
  CardModel(specializations[0], skyBlue, lightBlue), //القلب
  CardModel(
    specializations[1],
    green,
    lightGreen,
  ), //عام
  CardModel(
    specializations[2],
    orange,
    lightOrange,
  ), // نساء وتوليد
  CardModel(
    specializations[3],
    purple,
    purpleLight,
  ), // باطنه
  CardModel(
    specializations[4],
    green,
    lightGreen,
  ), // تجميل وترميم
  CardModel(
    specializations[5],
    skyBlue,
    lightBlue,
  ), //  اسنان
  CardModel(
    specializations[6],
    green,
    lightGreen,
  ), //  انف اذن
  CardModel(
    specializations[7],
    orange,
    lightOrange,
  ), // عيون
  CardModel(
    specializations[8],
    purple,
    purpleLight,
  ), //  عظام
  CardModel(
    specializations[9],
    green,
    lightGreen,
  ), // اطفال
];
