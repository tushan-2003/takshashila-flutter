import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:takshashila/views/admin/admin_add_course.dart';
import 'package:takshashila/views/admin/admin_home.dart';
import 'package:takshashila/views/admin/admin_courses.dart';
import 'package:takshashila/views/admin/admin_signout.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      key: _key,
      body: Row(
        children: [
          SideBarXExample(controller: _controller),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  switch (_controller.selectedIndex) {
                    case 0:
                      _key.currentState?.closeDrawer();
                      return const Center(child: Admin_Home());
                    case 1:
                      _key.currentState?.closeDrawer();
                      return const Center(
                        child: Admin_Course(),
                      );
                    case 2:
                      _key.currentState?.closeDrawer();
                      return const Center(
                        child: Add_Course(),
                      );
                    case 3:
                      _key.currentState?.closeDrawer();
                      return const Center(
                        child: Admin_SignOut(),
                      );
                    default:
                      return const Center(
                        child: Admin_Course(),
                      );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample({Key? key, required SidebarXController controller})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: const SidebarXTheme(
        textStyle: TextStyle(fontSize: 20),
        itemTextPadding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        hoverTextStyle: const TextStyle(fontSize: 20),
      ),
      extendedTheme: const SidebarXTheme(width: 300),
      headerBuilder: (context, extended) {
        return const SizedBox(
          height: 100,
          child: Icon(
            Icons.person,
            size: 80,
            color: Colors.white,
          ),
        );
      },
      items: const [
        SidebarXItem(
          icon: Icons.man,
          label: 'Home',
        ),
        SidebarXItem(icon: Icons.video_camera_back, label: 'Courses'),
        SidebarXItem(icon: Icons.add, label: 'Add Course'),
        SidebarXItem(icon: Icons.logout, label: 'Sign Out'),
      ],
    );
  }
}
