import 'package:dropdown_search/dropdown_search.dart';
import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/profile_model/bank_accounts/banknamesandtypes_model.dart';
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
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _confirmAccountController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();

  String _accountType = "Savings";
  String? _selectedBankId;
  String? _selectedBankName;

  String? _selectedCardTypeId;
  String? _selectedCardTypeName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final provider = Provider.of<BankaccountsViewmodel>(
        context,
        listen: false,
      );

      await provider.getBankNamesandCardTypes(context);

      if (provider.isBankNamesorCardTypesLoading) {
        return;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        "bankId": _selectedBankId,
        "cardTypeId": _selectedCardTypeId,
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
      hintText: label,
      hintStyle: TextStyle(fontWeight: FontWeight.w500),
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
      body: SafeArea(
        top: false,
        child: Consumer<BankaccountsViewmodel>(
          builder: (context, provider, _) {
            if (provider.isBankNamesorCardTypesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: colorscheme.tertiary,
                  strokeWidth: 3.0.w,
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16).r,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _labelName(colorscheme, "A/c Holder Name"),
                    SizedBox(height: 5.h),
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration("Account Holder Name"),
                      validator: (value) =>
                          value!.isEmpty ? "Enter account holder name" : null,
                    ),
                    const SizedBox(height: 10),

                    _labelName(colorscheme, "Bank Name"),
                    SizedBox(height: 5.h),

                    // TextFormField(
                    //   controller: _bankController,
                    //   decoration: _inputDecoration("Bank Name"),
                    //   validator: (value) =>
                    //       value!.isEmpty ? "Enter bank name" : null,
                    // ),
                    DropdownSearch<String>(
                      items: (String filter, LoadProps? props) {
                        return provider.bankNames
                            .map((e) => e.bankName)
                            .where(
                              (item) => item.toLowerCase().contains(
                                filter.toLowerCase(),
                              ),
                            )
                            .toList();
                      },

                      selectedItem: _selectedBankName,

                      popupProps: PopupProps.menu(
                        showSearchBox: true,

                        itemBuilder:
                            (
                              BuildContext context,
                              String item,
                              bool isSelected,
                              bool isHighlighted,
                            ) {
                              final bank = provider.bankNames.firstWhere(
                                (e) => e.bankName == item,
                              );

                              return ListTile(
                                selected: isSelected,
                                leading: Container(
                                  padding: EdgeInsets.all(5).r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50).r,
                                    color: colorscheme.onSecondary.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  child: Image.network(
                                    bank.bankImage,
                                    width: 30,
                                    height: 30,
                                    errorBuilder: (_, __, ___) => Icon(
                                      Icons.account_balance,
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  bank.bankName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },

                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search Bank",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      dropdownBuilder: (context, selectedItem) {
                        if (selectedItem == null) {
                          return Text('');
                        }

                        final bank = provider.bankNames.firstWhere(
                          (e) => e.bankName == selectedItem,
                        );

                        return Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5).r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50).r,
                                color: colorscheme.onSecondary.withValues(
                                  alpha: 0.2,
                                ),
                              ),

                              child: Image.network(
                                bank.bankImage,
                                width: 24,
                                height: 24,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.account_balance),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              bank.bankName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },

                      decoratorProps: DropDownDecoratorProps(
                        decoration: _inputDecoration("Select Bank"),
                      ),

                      validator: (value) =>
                          value == null || value.isEmpty ? "Select bank" : null,

                      onChanged: (value) {
                        final bank = provider.bankNames.firstWhere(
                          (e) => e.bankName == value,
                        );

                        setState(() {
                          _selectedBankId = bank.id;
                          _selectedBankName = bank.bankName;
                        });

                        debugPrint("Selected Bank ID: $_selectedBankId");
                      },
                    ),

                    const SizedBox(height: 10),
                    _labelName(colorscheme, "Card Type"),
                    SizedBox(height: 5.h),
                    DropdownSearch<String>(
                      items: (String filter, LoadProps? props) {
                        return provider.cardTypes
                            .map((e) => e.name)
                            .where(
                              (item) => item.toLowerCase().contains(
                                filter.toLowerCase(),
                              ),
                            )
                            .toList();
                      },

                      selectedItem: _selectedCardTypeName,

                      popupProps: PopupProps.menu(
                        showSearchBox: true,

                        itemBuilder:
                            (
                              BuildContext context,
                              String item,
                              bool isSelected,
                              bool isHighlighted,
                            ) {
                              final card = provider.cardTypes.firstWhere(
                                (e) => e.name == item,
                                orElse: () => CardType(
                                  id: "",
                                  name: item,
                                  image: "",
                                  createdAt: null,
                                  updatedAt: null,
                                  v: 0,
                                ),
                              );

                              return ListTile(
                                selected: isSelected,

                                leading: card.image.isNotEmpty
                                    ? Container(
                                        padding: EdgeInsets.all(5).r,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ).r,
                                          color: colorscheme.onSecondary
                                              .withValues(alpha: 0.2),
                                        ),
                                        child: Image.network(
                                          card.image,
                                          width: 32,
                                          height: 32,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.credit_card),
                                        ),
                                      )
                                    : const Icon(Icons.credit_card),

                                title: Text(
                                  card.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },

                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search Card Type",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      dropdownBuilder: (context, selectedItem) {
                        if (selectedItem == null) {
                          return const Text("");
                        }

                        final card = provider.cardTypes.firstWhere(
                          (e) => e.name == selectedItem,
                          orElse: () => CardType(
                            id: "",
                            name: selectedItem,
                            image: "",
                            createdAt: null,
                            updatedAt: null,
                            v: 0,
                          ),
                        );

                        return Row(
                          children: [
                            card.image.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.all(5).r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50).r,
                                      color: colorscheme.onSecondary.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),

                                    child: Image.network(
                                      card.image,
                                      width: 24,
                                      height: 24,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.credit_card),
                                    ),
                                  )
                                : const Icon(Icons.credit_card),

                            const SizedBox(width: 8),

                            Text(
                              card.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },

                      decoratorProps: DropDownDecoratorProps(
                        decoration: _inputDecoration("Select Card Type"),
                      ),

                      validator: (value) => value == null || value.isEmpty
                          ? "Select card type"
                          : null,

                      onChanged: (value) {
                        final card = provider.cardTypes.firstWhere(
                          (e) => e.name == value,
                        );

                        setState(() {
                          _selectedCardTypeId = card.id;
                          _selectedCardTypeName = card.name;
                        });

                        debugPrint(
                          "Selected CardType ID: $_selectedCardTypeId",
                        );
                      },
                    ),

                    const SizedBox(height: 10),
                    _labelName(colorscheme, "A/c Number"),
                    SizedBox(height: 5.h),

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

                    const SizedBox(height: 10),
                    _labelName(colorscheme, "Confirm A/c Number"),
                    SizedBox(height: 5.h),

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

                    const SizedBox(height: 10),
                    _labelName(colorscheme, "IFSC Code"),
                    SizedBox(height: 5.h),

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

                    const SizedBox(height: 10),
                    _labelName(colorscheme, "A/c Type"),
                    SizedBox(height: 5.h),

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
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorscheme.tertiary,
                          foregroundColor: colorscheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).r,
                          ),
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
      ),
    );
  }

  Widget _labelName(ColorScheme colorscheme, String name) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 4,
          decoration: BoxDecoration(
            color: colorscheme.tertiary,
            borderRadius: BorderRadius.circular(10).r,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          name,
          style: TextStyle(
            fontSize: 18.sp,
            color: colorscheme.tertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
