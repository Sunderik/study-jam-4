import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/core/core.dart';

const _mainTextFirstPart = 'Нажмите на шар';
const _mainTextSecondPartForTablet = 'или потрясите планшет';
const _mainTextSecondPartForPhone = 'или потрясите телефон';

/// Виджет центровки основного текста окна
class MainScreenText extends StatelessWidget {
  const MainScreenText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _Text(),
    );
  }
}

/// Виджет подбора текста для отображения
class _Text extends StatelessWidget {
  const _Text();

  @override
  Widget build(BuildContext context) {
    String? firstPart;
    String? secondPart;
    if (Device.isMonitor(context)) {
      firstPart = _mainTextFirstPart;
    } else if (Device.isTablet(context)) {
      firstPart = _mainTextFirstPart;
      secondPart = _mainTextSecondPartForTablet;
    } else if (Device.isPhone(context)) {
      firstPart = _mainTextFirstPart;
      secondPart = _mainTextSecondPartForPhone;
    }

    if (firstPart != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(firstPart, style: Theme.of(context).textTheme.bodyLarge),
          if (secondPart != null) Text(secondPart, style: Theme.of(context).textTheme.bodyLarge),
        ],
      );
    } else {
      return Container();
    }
  }
}
