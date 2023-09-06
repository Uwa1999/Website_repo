import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FDSTaglineSection extends StatefulWidget {
  const FDSTaglineSection({Key? key}) : super(key: key);

  @override
  State<FDSTaglineSection> createState() => _FDSTaglineSectionState();
}

class _FDSTaglineSectionState extends State<FDSTaglineSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.maroon06.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: FDSTaglineInfoSection(
                  title1: StringConst.WE_LISTEN,
                  hasTitle2: false,
                  body: '',
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.maroon06.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: FDSTaglineInfoSection(
                  title1: StringConst.WE_ANTICIPATE,
                  hasTitle2: false,
                  body: '',
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.maroon06.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: FDSTaglineInfoSection(
                  title1: StringConst.WE_DELIVER,
                  hasTitle2: false,
                  body: '',
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
