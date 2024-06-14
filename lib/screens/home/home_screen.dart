import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the theme provider from the widget tree.
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Build the home screen widget.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the message 'hello world'.
            Text(
              'hello world',
style:themeProvider.Isdark_theme ? TextStyles.font24WhiteBold : TextStyles.font24BlackBold,
),            
          

            ElevatedButton(
              onPressed: () {},
              child: const Text('click me'),
            ),

            SwitchListTile(
              title: Text(
                  themeProvider.Isdark_theme ? 'Dark Theme' : 'Light Theme'),
              value: themeProvider.Isdark_theme,
              onChanged: (value) {
                themeProvider.setdarkTheme(value: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
