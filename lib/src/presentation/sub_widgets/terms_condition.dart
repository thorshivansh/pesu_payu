import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pesu_payu/src/utils/my_button.dart';
import 'package:pesu_payu/src/utils/my_icons.dart';
import 'package:pesu_payu/src/utils/my_text.dart';


class TermsAndConditionView extends StatelessWidget {
  final PreferredSizeWidget? appBar;
 final TextStyle? textStyle;
  const TermsAndConditionView({super.key, this.appBar,  this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text("Terms and Conditions")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Online Charges Payments",
                // 
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "This online payment system is provided by PES UNIVERSITY. The PES UNIVERSITY may update these terms from time to time and any changes will be effective immediately on being set out on this portal. Please ensure that you are aware of the current terms. The country of domicile of PES UNIVERSITY is India and legal jurisdiction is Bengaluru, India.",
                style: textStyle,
              ),
              Text(
                "Please read these terms carefully before using the online payment facility. Using the online payment facility on this website indicates that you accept these terms. If you do not accept these terms do not use this facility.",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "All payments are subject to the following conditions",
                // 
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      size: 8,
                     
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "The description of items are specific to you when you log in with your user id and unique password.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      size: 8,
                    
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "All charges quoted are in Indian Rupees.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      size: 8,
                    
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "PES UNIVERSITY reserves the right to change the charges at any time.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      size: 8,
                    
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "Your payment to PES UNIVERSITY ., will normally reach PES UNIVERSITY account, within two working days.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
            
                     
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "We cannot accept liability for a payment not reaching the correct account of PES UNIVERSITY, due to quoting an incorrect account number or incorrect details, by you. Neither can we accept liability if payment is refused or declined by the Net Banking/ credit/ debit card supplier for any reason.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "If the Banker/card supplier declines payment, PES UNIVERSITY is under no obligation to bring this fact to your attention.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "It is for you (the Customer) to check with your bank/credit/debit card supplier that payment has been deducted from your account.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "In no event, PES UNIVERSITY will be liable for any damages whatsoever arising out of the use, computer virus, malware, inability to use, or the results of use of this site or any websites linked to this site, or the materials or information contained at any or all such sites, whether based on warranty, contract, tort or any other legal theory and whether or not advised of the possibility of such damages.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Refund Policy",
                
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Refunds, if applicable, at the discretion of the Management, will only be made as per the sources of Net Banking/ debit/ credit card used for the original transaction. For the avoidance of doubt, nothing in this Policy shall require PES UNIVERSITY to refund the Charges (or part thereof) unless such Charges (or part thereof) have previously been paid by the customer through online payment mode and the same has been credited into the accounts of PES UNIVERSITY and has the approval of the Management for refund. The Refunded amount will be credited back to source account within 5 working days.",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Cancel and Return Policy",
                
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Cancel and Return, if applicable, at the discretion of the Management, will only be made as per the sources of Net Banking/debit/credit card used for the original transaction. For the avoidance of doubt, nothing in this Policy shall require PES UNIVERSITY to Cancel and Return the Charges (or part thereof) unless such Charges (or part thereof) have previously been paid by the customer through online payment mode and the same has been credited into the accounts of PES UNIVERSITY and has the approval of the Management for Cancel and Return. The cancellation and return will take upto 20 working days.",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Privacy Policy",
                
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "This Privacy Policy applies to all of the Fees, Payment of Dues, Charges and related payments payable to PES UNIVERSITY through online mode. Sometimes, we may post specific privacy notices to explain in more detail. If you have any questions about this Privacy Policy, please feel free to contact us through our email accounts pesurr@pes.edu.",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Changes to our Privacy Policy",
                
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "PES UNIVERSITY reserves the entire right to modify/ amend/ remove this privacy statement anytime and without any reason. Nothing contained herein creates or is intended to create a contract/agreement between PES UNIVERSITY and any user visiting the website or providing identifying information of any kind.",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Contact Email accounts.pesurr@pes.edu.",
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "DND (Do Not Disturb) Policy",
                
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "If you wish to stop any further sms/email alerts/contacts from our side, all you need to do is to send an email to pesurr@pes.edu with your registered mobile number and you will be excluded from the alerts list.",
                style: textStyle,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "Charges, Taxes applicable for online payment through Payment Gateway will be borne by the customer.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "In respect of any failed transactions of any of the Customers, processed through this service, the amount will be refunded after deducting the transaction charges.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "In respect of any failed transactions of any of the Customers, processed through this service, the amount will be refunded after deducting the transaction charges.",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: MyIcons(
                      Icons.circle,
                      
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 10,
                      "The Parent/Guardian shall pay an additional Convenience Fee plus taxes for every transaction through Credit Card/Debit Card & approximately for Net Banking including Service Tax 18% is shown as below :",
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  border: TableBorder.all(),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Accepted Channel',
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Rates',
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('UPI*	')),
                        DataCell(Text('Nil')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Debit card Rupay*	')),
                        DataCell(Text('Nil')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Internet Banking (SBI)	')),
                        DataCell(Text('Rs.12+taxes')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Internet Banking (HDFC,ICICI,AXIS)	')),
                        DataCell(Text('Rs.12+taxes')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Internet Banking (others)	')),
                        DataCell(Text('Rs.12+taxes')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                            Text('Debit Card upto 2000 other than Rupay	')),
                        DataCell(Text('0.40%+taxes')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                            Text('Debit Card above 2000 other than Rupay	')),
                        DataCell(Text('0.40%+taxes')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Credit card	')),
                        DataCell(Text('0.40%+taxes')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: MyButton(
                        onPressed: () {
                          Get.back();
                        },
                        label: "Close"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
