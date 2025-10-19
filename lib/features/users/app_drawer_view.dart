import 'package:ideal_store/main.dart';

class AppDrawerView extends StatelessWidget {
  const AppDrawerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppDrawerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppDrawerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
