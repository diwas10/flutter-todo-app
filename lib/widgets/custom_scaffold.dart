import "package:flutter/material.dart";

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingIcon;
  final String title;
  final Drawer? drawer;
  final List<Widget>? actions;
  final bool? disableLeading;
  const CustomScaffold(
      {Key? key,
      required this.body,
      this.drawer,
      this.floatingIcon,
      this.actions,
      this.disableLeading,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 23),
        ),
        backgroundColor: Colors.grey[100],
        shadowColor: Colors.transparent,
        iconTheme: ThemeData()
            .iconTheme
            .copyWith(color: Theme.of(context).primaryColor),
        actions: actions,
        leading: disableLeading == true
            ? IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  size: 35,
                ),
                onPressed: () => Navigator.pop(context))
            : null,
      ),
      body: body,
      floatingActionButton: floatingIcon,
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today_outlined),
              label: "",
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: "",
              backgroundColor: Theme.of(context).primaryColor)
        ],
      ),
    );
  }
}
