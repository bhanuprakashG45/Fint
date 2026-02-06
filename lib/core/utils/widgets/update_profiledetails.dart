import 'package:fint/core/constants/exports.dart';

class UpdateProfileDialog extends StatefulWidget {
  final String currentName;
  final String currentPincode;

  const UpdateProfileDialog({
    Key? key,
    required this.currentName,
    required this.currentPincode,
  }) : super(key: key);

  @override
  State<UpdateProfileDialog> createState() => _UpdateProfileDialogState();
}

class _UpdateProfileDialogState extends State<UpdateProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _pincodeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _pincodeController = TextEditingController(text: widget.currentPincode);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileprovider = Provider.of<ProfileViewmodel>(
      context,
      listen: false,
    );
    final colorscheme = Theme.of(context).colorScheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      backgroundColor: colorscheme.onPrimary,
      title: Text(
        'Update Profile',
        style: TextStyle(
          color: colorscheme.tertiary,
          fontWeight: FontWeight.bold,
        ),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(
                color: colorscheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorscheme.onSecondary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorscheme.onSecondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorscheme.tertiary, width: 2),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _pincodeController,
            decoration: InputDecoration(
              labelText: 'PinCode',
              labelStyle: TextStyle(
                color: colorscheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorscheme.tertiary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorscheme.tertiary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorscheme.tertiary, width: 2),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: colorscheme.tertiary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: colorscheme.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorscheme.tertiary,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorscheme.tertiary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            if (_nameController.text.trim().isEmpty) {
              ToastHelper.show(
                context,
                "Name cannot be empty",
                type: ToastificationType.error,
                duration: const Duration(seconds: 3),
              );
              return;
            }
            ;
            if (_pincodeController.text.trim().length != 6) {
              ToastHelper.show(
                context,
                "PinCode must be 6 digits",
                type: ToastificationType.error,
                duration: const Duration(seconds: 3),
              );
              return;
            }
            ;
            await profileprovider.updateProfile(
              context,
              name: _nameController.text.trim(),
              pinCode: _pincodeController.text.trim(),
            );
            await profileprovider.fetchProfileDetails(context);

            Navigator.of(context).pop();
          },
          child: Text(
            'Update',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorscheme.primaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
