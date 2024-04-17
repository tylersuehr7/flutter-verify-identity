part of '../home_screen.dart';

class _HomeListItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _HomeListItem(this.label, {
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: const CupertinoListTileChevron(),
      onTap: onTap,
    );
  }
}
