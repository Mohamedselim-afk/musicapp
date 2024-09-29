import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/themes/thems_provider.dart';
import 'package:provider/provider.dart';

class settingspage extends StatelessWidget{
  const settingspage ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text("S E T T I N G S")
      ),
      body:  Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        ),
        padding:const EdgeInsets.all(16),
        margin:const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,// Switch ponint in right
          children: [
            // dark mode 
            const Text("Dark Mode",
              style: TextStyle(fontWeight:FontWeight.bold , fontSize: 14,),

            ),
            // Switch
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isdarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}