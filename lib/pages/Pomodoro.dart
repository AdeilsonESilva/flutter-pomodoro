import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/TimeInput.dart';
import 'package:pomodoro/components/Timer.dart';
import 'package:provider/provider.dart';
import '../store/pomodoro.store.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Timer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeInput(
                    title: 'Trabalho',
                    value: store.timeWork,
                    inc: store.started && store.isWork()
                        ? null
                        : store.incTimeWork,
                    dec:
                        (store.started && store.isWork()) || store.timeWork == 1
                            ? null
                            : store.decTimeWork,
                  ),
                  TimeInput(
                    title: 'Descanso',
                    value: store.timeRest,
                    inc: store.started && store.isRest()
                        ? null
                        : store.incTimeRest,
                    dec:
                        (store.started && store.isRest()) || store.timeRest == 1
                            ? null
                            : store.decTimeRest,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
