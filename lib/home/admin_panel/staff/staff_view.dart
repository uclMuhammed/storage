import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

part 'staff_view_model.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> with StaffViewModel {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, size),
          medium: _buildTabletLayout(context, size),
          large: _buildDesktopLayout(context, size),
        );
      },
    );
  }

  //--------------------------------------------------------------
  Widget _staffSearch() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: context.myTextFormField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.borderRadius),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _addStaff() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () => showAddStaffDialog(context),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _staffGridList() {
    return SizedBox(
      height: context.cardHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          context.responsiveGridView(
            crossAxiscount: 1,
            padding: EdgeInsets.all(context.smallPadding),
            childAspectRatio: 1,
            children: List.generate(
              10,
              (index) {
                return context.myCard(
                  onTap: () {},
                  title: 'Card',
                  subtitle: 'Subtitle',
                  icon: Icons.supervisor_account,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _staffDetails() {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Staff',
              style: TextStyle(
                fontSize: context.bodySize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).paddingLeft(context.smallPadding),
        ],
      ),
    );
  }
  //--------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return const Scaffold(body: Center(child: Text('Staff View')));
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints size) {
    return const Scaffold(body: Center(child: Text('Staff View')));
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            _staffSearch(),
            Row(
              children: [
                context
                    .mySubheadingText(text: 'Staff')
                    .paddingAll(context.padding),
                const Spacer(),
                _addStaff().paddingRight(context.padding),
              ],
            ),
            _staffGridList(),
            Expanded(
              child: _staffDetails().paddingAll(context.padding),
            ),
          ],
        ),
      ),
    );
  }
}
