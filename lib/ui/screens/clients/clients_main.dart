import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../shared/widgets/animation.dart';
import '../shared/widgets/buttons/textandimage_widget.dart';
import '../shared/widgets/photoClients.dart';
///old
// class ClientsList extends StatelessWidget {
//   static const String route = '/ClientsList';
//   const ClientsList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//   color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               const Text(
//                 'Come and Join us using our',
//                 style: TextStyle(
//                   fontSize: 50,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400,
//                   height: 1.4,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 370.0, top: 60.0),
//                 child: AnimatedGradientText(
//                   animation: _animation,
//                   text: "all in one",
//                 ),
//               ),
//             ],
//           ),
//
//           Text('all-in-one banking tech solution.', style: TextStyle(
//             fontSize: 50,
//             color: Colors.white,
//             fontWeight: FontWeight.w400,
//             height: 1.4,
//           ),),
//           const SizedBox(height: 40),
//           // TitleWithImageList(
//           //   title: 'Fintech',
//           //   imagePaths: [
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //   ],
//           // ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             Text('Fintect',style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.bold),),
//             Padding(
//               padding: const EdgeInsets.only(left: 120, right: 120),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/ag-bank-emoney.png'))),
//                       Spacer(),
//                       Container(
//                           width: 190,
//                           height: 190,
//                           child: Image(image: AssetImage('assets/images/bank-bpd-bali-emoney.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/bank-kalsel-emoney.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/bank-sahabat.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/banking-tech.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/IMkas.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/ottocash.png'))),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/ottokonek.png'))),
//                       SizedBox(width: 60,),
//                       Container(
//                           width: 200,
//                           height: 200,
//                           child: Image(image: AssetImage('assets/images/ottopayv2.png'))),
//                      SizedBox(width: 60,),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/pac-cash.png'))),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//
//             ],
//           ),
//
//           TitleWithImageList(
//             title: 'Financial Inclusion',
//             imagePaths: [
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//               // 'assets/logos/fas_cash.png',
//               // 'assets/logos/ottopay.png',
//               // 'assets/logos/ottocash.png',
//               // 'assets/logos/bank_ag.png',
//               // 'assets/logos/sobatku.png',
//               // 'assets/logos/bank_kalsel.png',
//             ],
//           ),
//
//           TitleWithImageList(
//             title: 'MFIs',
//             imagePaths: [
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               // 'assets/logos/fas_cash.png',
//               // 'assets/logos/ottopay.png',
//               // 'assets/logos/ottocash.png',
//               // 'assets/logos/bank_ag.png',
//               // 'assets/logos/sobatku.png',
//               // 'assets/logos/bank_kalsel.png',
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//



class ClientsList extends StatefulWidget {
  static const String route = '/ClientsList';
  const ClientsList({Key? key}) : super(key: key);

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper widget to build rows of images with spacing and wrapping
  Widget _buildLogoRow(List<String> logos) {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      alignment: WrapAlignment.start,
      children: logos
          .map(
            (logo) =>
            Container(
              width: 150,
              height: 150,
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
              ),
            ),
      )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    // Limit max content width for large screens
    final maxContentWidth = 1200.0;

    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final isMobile = width < 600;
                  final fontSize = isMobile ? 30.0 : 50.0;

                  final baseTextStyle = TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  );

                  if (isMobile) {
                    // MOBILE VIEW (stacked layout)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Come and Join us', style: baseTextStyle),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('using our ', style: baseTextStyle),
                            AnimatedGradientText(
                              animation: _animation,
                              text: 'all-in-one',
                              fontSize: fontSize,
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                  'assets/images/twinkling2.png'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'banking tech solution.', style: baseTextStyle),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                  'assets/images/twinkling1.png'),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    // DESKTOP VIEW (inline layout)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 4,
                          children: [
                            Text('Come and Join us using our',
                                style: baseTextStyle),
                            AnimatedGradientText(
                              animation: _animation,
                              text: 'all-in-one',
                              fontSize: fontSize,
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                  'assets/images/twinkling2.png'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                                'banking tech solution.', style: baseTextStyle),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                  'assets/images/twinkling1.png'),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 40),

              _buildCategorySection(
                title: 'Fintech',
                logos: [
                  'assets/images/pac-cash.png',
                  'assets/images/bank-bpd-bali-emoney.png',
                  'assets/images/ottopayv2.png',
                  'assets/images/ottokonek.png',
                  'assets/images/ag-bank-emoney.png',
                  'assets/images/fintech_sobatku.png',
                  'assets/images/bank-kalsel-emoney.png',
                  'assets/images/bank-sahabat.png',
                  'assets/images/ottocash.png',
                  'assets/images/IMkas.png',
                ],
              ),

              const SizedBox(height: 40),

              _buildCategorySection(
                title: 'Financial Inclusion',
                logos: [
                  'assets/images/fi_card_bank.png',
                  'assets/images/fi_card_rbi.png',
                  'assets/images/fi_bank_ina.png',
                  'assets/images/fi_nrb_global_bank.png',
                  'assets/images/fi_bank_sulsebar.png',
                  'assets/images/fi_card_sme.png',
                  'assets/images/fi_bank_jambi.png',
                  'assets/images/fi_bank_mas.png',
                  'assets/images/fi_bank_bpd_bali.png',
                  'assets/images/fi_bank_kalsel.png',
                  'assets/images/fi_bank_ntt.png',
                ],
              ),

              const SizedBox(height: 40),

              _buildCategorySection(
                title: 'MFIs',
                logos: [
                  'assets/images/mfi1.png',
                  'assets/images/mfi_BPR_KS.png',
                  'assets/images/mfi_bpr_sejahtera_batam.png',
                  'assets/images/mfi_bpr_supra.png',
                  'assets/images/mfi_credit_union_bonaventura.png',
                  'assets/images/mfi_credit_union_cindelaras_tumangkar.png',
                  'assets/images/mfi_credit_union_femung_pebaya.png',
                  'assets/images/mfi_credit_union_gerbang_kasih.png',
                  'assets/images/mfi_credit_union_hati_amboina.png',
                  'assets/images/mfi_credit_union_jembatan_kasih.png',
                  'assets/images/mfi_credit_union_kridha.png',
                  'assets/images/mfi_credit_union_mekar_kasih.png',
                  'assets/images/mfi_credit_union_mosinggani_palu.png',
                  'assets/images/mfi_credit_union_ndar_sesepok.png',
                  'assets/images/mfi_credit_union_pelita_sejahtera.png',
                  'assets/images/mfi_credit_union_semangat_warga.png',
                  'assets/images/mfi_credit_union_sumber_kasih_sejahtera.png',
                  'assets/images/mfi_credit_union_usaha_kita.png',
                  'assets/images/mfi_cu_angudi_laras.png',
                  'assets/images/mfi_cu_bahtera_sejahtera.png',
                  'assets/images/mfi_cu_deus_providebit.png',
                  'assets/images/mfi_cu_likku_aba.png',
                  'assets/images/mfi_cu_mototabian.png',
                  'assets/images/mfi_cu_prima.png',
                  'assets/images/mfi_cu_sari_intugin.png',
                  'assets/images/mfi_cu_sohagaini.png',
                  'assets/images/mfi_cu_stella_maris.png',
                  'assets/images/mfi_cu_tilung_jaya.png',
                  'assets/images/mfi_cu_tunas_mekar.png',
                  'assets/images/mfi_cusinar_saron.png',
                  'assets/images/mfi_cusr_ampah.png',
                  'assets/images/mfi_ksp_credit_union_daya_lestari.png',
                  'assets/images/mfi_ksp_cu_kusapa.png',
                  'assets/images/mfi_ksp_cu_sejahtera_makmur_bersama.png',
                  'assets/images/mfi_ksp_multi_artha_utama.png',
                  'assets/images/mfi_kspcu_pangudi.png',
                  'assets/images/mfi_prima_danarta.png',
                  'assets/images/mfi_pusat_koperasi_credit_union.png',
                  'assets/images/mfi_sejarah_berdirinya_credit_union.png',
                  'assets/images/mfi_talita_kum.png',
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

// Helper widget to build each category section
  Widget _buildCategorySection({
    required String title,
    required List<String> logos,
  }) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        isMobile
            ? AutoScrollWidgetScroller(
          height: 100,
          itemWidth: 120,
          spacing: 24,
          scrollDelay: const Duration(seconds: 2),
          scrollDuration: const Duration(milliseconds: 800),
          items: logos.map((logo) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                  height: 80,
                  width: 120,
                ),
              ),
            );
          }).toList(),
        )
            : Wrap(
          spacing: 40,
          runSpacing: 20,
          children: logos.map((logo) {
            double logoSize = 150;
            if (logo.contains('bank-bpd-bali-emoney.png')) logoSize = 190;
            if (logo.contains('ottopayv2.png')) logoSize = 200;
            if (logo.contains('card-bank.png')) logoSize = 200;

            return SizedBox(
              width: logoSize,
              height: logoSize,
              child: Image.asset(logo, fit: BoxFit.contain),
            );
          }).toList(),
        ),
      ],
    );
  }
}




// class ClientsList extends StatelessWidget {
//     static const String route = '/ClientsList';
//   const ClientsList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1000,
//       height: 1000,
//       color: Colors.red,
//     );
//   }
// }
