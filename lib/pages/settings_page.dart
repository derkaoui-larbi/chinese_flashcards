import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flashcards/components/app/custom_appbar.dart';
import 'package:flutter_flashcards/notifiers/settings_notifier.dart';
import 'package:flutter_flashcards/utils/methods.dart';
import 'package:provider/provider.dart';

import '../components/settings/settings_tile.dart';
import '../components/settings/switch_button.dart';
import '../configs/constants.dart';
import '../databases/database_manager.dart';
import '../enums/settings.dart';
import 'LandingPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<SettingsNotifier>(context, listen: false).loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (_, notifier, __) {
        bool audioFirst = notifier.displayOptions[Settings.audioOnly] ?? false;

        return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kAppBarHeight),
              child: CustomAppBar(topic: '')),
          body: Stack(
            children: [
              Column(
                children: [
                  SwitchButton(
                    disabled: audioFirst,
                    displayOption: Settings.englishFirst,
                  ),
                  SwitchButton(
                    disabled: audioFirst,
                    displayOption: Settings.showPinyin,
                  ),
                  const SwitchButton(
                    displayOption: Settings.audioOnly,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SettingsTile(
                    title: 'Reset',
                    icon: const Icon(Icons.refresh),
                    callback: () async {
                      notifier.resetSettings();
                      runQuickBox(context: context, text: 'Settings Reset');
                      await DatabaseManager().removeDatabase();
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        if (!mounted) return;
                        Navigator.maybePop(context);
                      });
                    },
                  ),
                  SettingsTile(
                    title: 'Exit App',
                    icon: const Icon(Icons.exit_to_app),
                    callback: () {

                      Navigator.pushReplacementNamed(context, LandingPage.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
