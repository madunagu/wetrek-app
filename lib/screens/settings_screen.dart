
import 'package:flutter/material.dart';
import 'package:wetrek/mixins/popup_mixin.dart';
import 'package:wetrek/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) => SettingsScreen());
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with MyPopupMixin {
  final List<bool> settingsVals = [true, true, false, true];
  final List<String> settingsLists = [
    'Show Location',
    'Show Favorite Places',
    'Show Age',
    'Show Address'
  ];

  void saveSettings() {
    showLoader();
  }

  initState() {
    // this
    super.initState();
  }

  void changed(int i, bool val) {
    settingsVals[i] = val;
    print(settingsVals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Settings',
        rightIcon: Icons.check,
        onPressed: saveSettings,
      ),
      body: Column(
        // children: for(s in settingsList)
        children: [
          for (var i = 0; i < settingsLists.length; i++)
            SettingRow(
              title: settingsLists[i],
              value: settingsVals[i],
              index: i,
              onChanged: changed,
            ),
        ],
      ),
    );
  }
}

class SettingRow extends StatefulWidget {
  final String title;
  final bool value;
  final int index;
  final Function(int, bool) onChanged;
  const SettingRow({
    Key? key,
    required this.title,
    this.value = false,
    required this.onChanged,
    required this.index,
  }) : super(key: key);

  @override
  _SettingRowState createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  late bool value;
  @override
  initState() {
    value = widget.value;
    super.initState();
  }

  void switchValue(bool val) {
    widget.onChanged(widget.index, val);
    setState(() {
      value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 18,
        bottom: 18,
        left: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffF4F4F6),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff454F63),
              height: 21 / 16,
            ),
          ),
          Switch(value: value, onChanged: switchValue)
        ],
      ),
    );
  }
}
