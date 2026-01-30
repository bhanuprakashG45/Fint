import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/bankaccounts_vm/bankaccounts_viewmodel.dart';

class AddBankAccountScreen extends StatefulWidget {
  final bool isComingFromLogin;
  const AddBankAccountScreen({super.key, required this.isComingFromLogin});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _confirmAccountController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();

  String _accountType = "Savings";

  @override
  void dispose() {
    _nameController.dispose();
    _bankController.dispose();
    _accountController.dispose();
    _confirmAccountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final provider = Provider.of<BankaccountsViewmodel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> data = {
        "accountHolderName": _nameController.text.trim(),
        "bankName": _bankController.text.trim(),
        "bankAccountNumber": _accountController.text.trim(),
        "ifscCode": _ifscController.text.trim(),
        "accountType": _accountType,
      };

      debugPrint("Bank Account Data: $data");

      bool response = await provider.addBankAccount(context, data);
      response && widget.isComingFromLogin
          ? Navigator.pushNamed(context, RoutesName.homescreen)
          : Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    final RegExp _ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    final RegExp _accountNumberRegex = RegExp(r'^\d{9,18}$');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.primaryContainer,
        title: Text(
          "Add Bank Account",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<BankaccountsViewmodel>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration("Account Holder Name"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter account holder name" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _bankController,
                    decoration: _inputDecoration("Bank Name"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter bank name" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _accountController,
                    decoration: _inputDecoration("Account Number"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter account number";
                      }
                      if (!_accountNumberRegex.hasMatch(value.trim())) {
                        return "Account number must be 9–18 digits";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmAccountController,
                    decoration: _inputDecoration("Confirm Account Number"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm account number";
                      }
                      if (value.trim() != _accountController.text.trim()) {
                        return "Account numbers do not match";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _ifscController,
                    decoration: _inputDecoration("IFSC Code"),
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter IFSC code";
                      }
                      if (!_ifscRegex.hasMatch(value.trim().toUpperCase())) {
                        return "Enter a valid IFSC code";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _accountType,
                    decoration: _inputDecoration("Account Type"),
                    items: const [
                      DropdownMenuItem(
                        value: "Savings",
                        child: Text("Savings"),
                      ),
                      DropdownMenuItem(
                        value: "Current",
                        child: Text("Current"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _accountType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorscheme.tertiary,
                        foregroundColor: colorscheme.primaryContainer,
                      ),
                      onPressed: provider.isBankAccountAdding
                          ? null
                          : _submitForm,
                      child: provider.isBankAccountAdding
                          ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                color: colorscheme.primaryContainer,
                              ),
                            )
                          : Text(
                              "Add Account",
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
