//
//  BaseFont.h
//  buddhismYDniu
//
//  Created by aolei on 16/5/11.
//  Copyright © 2016年 aolei. All rights reserved.
//

/*
 
 familyName = Thonburi
 2018-07-04 10:30:59.765291+0800 buddhismYDniu[1990:438359]     fontName = Thonburi-Bold
 2018-07-04 10:30:59.765344+0800 buddhismYDniu[1990:438359]     fontName = Thonburi
 2018-07-04 10:30:59.765393+0800 buddhismYDniu[1990:438359]     fontName = Thonburi-Light
 2018-07-04 10:30:59.765448+0800 buddhismYDniu[1990:438359] familyName = Khmer Sangam MN
 2018-07-04 10:30:59.765554+0800 buddhismYDniu[1990:438359]     fontName = KhmerSangamMN
 2018-07-04 10:30:59.765609+0800 buddhismYDniu[1990:438359] familyName = Kohinoor Telugu
 2018-07-04 10:30:59.765718+0800 buddhismYDniu[1990:438359]     fontName = KohinoorTelugu-Regular
 2018-07-04 10:30:59.765767+0800 buddhismYDniu[1990:438359]     fontName = KohinoorTelugu-Light
 2018-07-04 10:30:59.765814+0800 buddhismYDniu[1990:438359]     fontName = KohinoorTelugu-Medium
 2018-07-04 10:30:59.765869+0800 buddhismYDniu[1990:438359] familyName = Snell Roundhand
 2018-07-04 10:30:59.765975+0800 buddhismYDniu[1990:438359]     fontName = SnellRoundhand-Black
 2018-07-04 10:30:59.772411+0800 buddhismYDniu[1990:438359]     fontName = SnellRoundhand-Bold
 2018-07-04 10:30:59.772486+0800 buddhismYDniu[1990:438359]     fontName = SnellRoundhand
 2018-07-04 10:30:59.772545+0800 buddhismYDniu[1990:438359] familyName = Academy Engraved LET
 2018-07-04 10:30:59.772699+0800 buddhismYDniu[1990:438359]     fontName = AcademyEngravedLetPlain
 2018-07-04 10:30:59.772757+0800 buddhismYDniu[1990:438359] familyName = Marker Felt
 2018-07-04 10:30:59.772864+0800 buddhismYDniu[1990:438359]     fontName = MarkerFelt-Thin
 2018-07-04 10:30:59.772912+0800 buddhismYDniu[1990:438359]     fontName = MarkerFelt-Wide
 2018-07-04 10:30:59.772963+0800 buddhismYDniu[1990:438359] familyName = Avenir
 2018-07-04 10:30:59.773113+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Heavy
 2018-07-04 10:30:59.773163+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Oblique
 2018-07-04 10:30:59.773210+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Black
 2018-07-04 10:30:59.773257+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Book
 2018-07-04 10:30:59.783575+0800 buddhismYDniu[1990:438359]     fontName = Avenir-BlackOblique
 2018-07-04 10:30:59.783634+0800 buddhismYDniu[1990:438359]     fontName = Avenir-HeavyOblique
 2018-07-04 10:30:59.783681+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Light
 2018-07-04 10:30:59.783729+0800 buddhismYDniu[1990:438359]     fontName = Avenir-MediumOblique
 2018-07-04 10:30:59.783776+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Medium
 2018-07-04 10:30:59.783824+0800 buddhismYDniu[1990:438359]     fontName = Avenir-LightOblique
 2018-07-04 10:30:59.783872+0800 buddhismYDniu[1990:438359]     fontName = Avenir-Roman
 2018-07-04 10:30:59.783920+0800 buddhismYDniu[1990:438359]     fontName = Avenir-BookOblique
 2018-07-04 10:30:59.784128+0800 buddhismYDniu[1990:438359] familyName = Geeza Pro
 2018-07-04 10:30:59.784307+0800 buddhismYDniu[1990:438359]     fontName = GeezaPro-Bold
 2018-07-04 10:30:59.784359+0800 buddhismYDniu[1990:438359]     fontName = GeezaPro
 2018-07-04 10:30:59.787814+0800 buddhismYDniu[1990:438359] familyName = Arial Rounded MT Bold
 2018-07-04 10:30:59.787941+0800 buddhismYDniu[1990:438359]     fontName = ArialRoundedMTBold
 2018-07-04 10:30:59.788022+0800 buddhismYDniu[1990:438359] familyName = Trebuchet MS
 2018-07-04 10:30:59.788135+0800 buddhismYDniu[1990:438359]     fontName = Trebuchet-BoldItalic
 2018-07-04 10:30:59.788187+0800 buddhismYDniu[1990:438359]     fontName = TrebuchetMS
 2018-07-04 10:30:59.788234+0800 buddhismYDniu[1990:438359]     fontName = TrebuchetMS-Bold
 2018-07-04 10:30:59.788281+0800 buddhismYDniu[1990:438359]     fontName = TrebuchetMS-Italic
 2018-07-04 10:30:59.788332+0800 buddhismYDniu[1990:438359] familyName = Arial
 2018-07-04 10:30:59.788438+0800 buddhismYDniu[1990:438359]     fontName = ArialMT
 2018-07-04 10:30:59.788488+0800 buddhismYDniu[1990:438359]     fontName = Arial-BoldItalicMT
 2018-07-04 10:30:59.788535+0800 buddhismYDniu[1990:438359]     fontName = Arial-ItalicMT
 2018-07-04 10:30:59.788582+0800 buddhismYDniu[1990:438359]     fontName = Arial-BoldMT
 2018-07-04 10:30:59.799438+0800 buddhismYDniu[1990:438359] familyName = Menlo
 2018-07-04 10:30:59.799606+0800 buddhismYDniu[1990:438359]     fontName = Menlo-BoldItalic
 2018-07-04 10:30:59.799658+0800 buddhismYDniu[1990:438359]     fontName = Menlo-Regular
 2018-07-04 10:30:59.799706+0800 buddhismYDniu[1990:438359]     fontName = Menlo-Bold
 2018-07-04 10:30:59.799754+0800 buddhismYDniu[1990:438359]     fontName = Menlo-Italic
 2018-07-04 10:30:59.799862+0800 buddhismYDniu[1990:438359] familyName = Gurmukhi MN
 2018-07-04 10:30:59.800010+0800 buddhismYDniu[1990:438359]     fontName = GurmukhiMN-Bold
 2018-07-04 10:30:59.800063+0800 buddhismYDniu[1990:438359]     fontName = GurmukhiMN
 2018-07-04 10:30:59.800115+0800 buddhismYDniu[1990:438359] familyName = Malayalam Sangam MN
 2018-07-04 10:30:59.800246+0800 buddhismYDniu[1990:438359]     fontName = MalayalamSangamMN
 2018-07-04 10:30:59.800299+0800 buddhismYDniu[1990:438359]     fontName = MalayalamSangamMN-Bold
 2018-07-04 10:30:59.800351+0800 buddhismYDniu[1990:438359] familyName = Kannada Sangam MN
 2018-07-04 10:30:59.803896+0800 buddhismYDniu[1990:438359]     fontName = KannadaSangamMN
 2018-07-04 10:30:59.803957+0800 buddhismYDniu[1990:438359]     fontName = KannadaSangamMN-Bold
 2018-07-04 10:30:59.804012+0800 buddhismYDniu[1990:438359] familyName = Bradley Hand
 2018-07-04 10:30:59.804116+0800 buddhismYDniu[1990:438359]     fontName = BradleyHandITCTT-Bold
 2018-07-04 10:30:59.804172+0800 buddhismYDniu[1990:438359] familyName = Bodoni 72 Oldstyle
 2018-07-04 10:30:59.804281+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoOSITCTT-BookIt
 2018-07-04 10:30:59.804330+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoOSITCTT-Bold
 2018-07-04 10:30:59.804377+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoOSITCTT-Book
 2018-07-04 10:30:59.804432+0800 buddhismYDniu[1990:438359] familyName = Cochin
 2018-07-04 10:30:59.804577+0800 buddhismYDniu[1990:438359]     fontName = Cochin-Bold
 2018-07-04 10:30:59.804630+0800 buddhismYDniu[1990:438359]     fontName = Cochin-BoldItalic
 2018-07-04 10:30:59.810734+0800 buddhismYDniu[1990:438359]     fontName = Cochin-Italic
 2018-07-04 10:30:59.810797+0800 buddhismYDniu[1990:438359]     fontName = Cochin
 2018-07-04 10:30:59.810854+0800 buddhismYDniu[1990:438359] familyName = Sinhala Sangam MN
 2018-07-04 10:30:59.810987+0800 buddhismYDniu[1990:438359]     fontName = SinhalaSangamMN
 2018-07-04 10:30:59.811037+0800 buddhismYDniu[1990:438359]     fontName = SinhalaSangamMN-Bold
 2018-07-04 10:30:59.811091+0800 buddhismYDniu[1990:438359] familyName = PingFang HK
 2018-07-04 10:30:59.811270+0800 buddhismYDniu[1990:438359]     fontName = PingFangHK-Light
 2018-07-04 10:30:59.811330+0800 buddhismYDniu[1990:438359]     fontName = PingFangHK-Semibold
 2018-07-04 10:30:59.811380+0800 buddhismYDniu[1990:438359]     fontName = PingFangHK-Thin
 2018-07-04 10:30:59.811427+0800 buddhismYDniu[1990:438359]     fontName = PingFangHK-Medium
 2018-07-04 10:30:59.811475+0800 buddhismYDniu[1990:438359]     fontName = PingFangHK-Ultralight
 2018-07-04 10:30:59.811523+0800 buddhismYDniu[1990:438359]     fontName = PingFangHK-Regular
 2018-07-04 10:30:59.815285+0800 buddhismYDniu[1990:438359] familyName = Kohinoor Bangla
 2018-07-04 10:30:59.815451+0800 buddhismYDniu[1990:438359]     fontName = KohinoorBangla-Semibold
 2018-07-04 10:30:59.815504+0800 buddhismYDniu[1990:438359]     fontName = KohinoorBangla-Regular
 2018-07-04 10:30:59.815552+0800 buddhismYDniu[1990:438359]     fontName = KohinoorBangla-Light
 2018-07-04 10:30:59.815607+0800 buddhismYDniu[1990:438359] familyName = Damascus
 2018-07-04 10:30:59.815721+0800 buddhismYDniu[1990:438359]     fontName = DamascusBold
 2018-07-04 10:30:59.815770+0800 buddhismYDniu[1990:438359]     fontName = Damascus
 2018-07-04 10:30:59.815817+0800 buddhismYDniu[1990:438359]     fontName = DamascusLight
 2018-07-04 10:30:59.815864+0800 buddhismYDniu[1990:438359]     fontName = DamascusMedium
 2018-07-04 10:30:59.815910+0800 buddhismYDniu[1990:438359]     fontName = DamascusSemiBold
 2018-07-04 10:30:59.815966+0800 buddhismYDniu[1990:438359] familyName = Al Nile
 2018-07-04 10:30:59.817808+0800 buddhismYDniu[1990:438359]     fontName = AlNile-Bold
 2018-07-04 10:30:59.817962+0800 buddhismYDniu[1990:438359]     fontName = AlNile
 2018-07-04 10:30:59.818022+0800 buddhismYDniu[1990:438359] familyName = Farah
 2018-07-04 10:30:59.818188+0800 buddhismYDniu[1990:438359]     fontName = Farah
 2018-07-04 10:30:59.818253+0800 buddhismYDniu[1990:438359] familyName = Papyrus
 2018-07-04 10:30:59.818388+0800 buddhismYDniu[1990:438359]     fontName = Papyrus-Condensed
 2018-07-04 10:30:59.818440+0800 buddhismYDniu[1990:438359]     fontName = Papyrus
 2018-07-04 10:30:59.818496+0800 buddhismYDniu[1990:438359] familyName = Verdana
 2018-07-04 10:30:59.818607+0800 buddhismYDniu[1990:438359]     fontName = Verdana-BoldItalic
 2018-07-04 10:30:59.818658+0800 buddhismYDniu[1990:438359]     fontName = Verdana-Italic
 2018-07-04 10:30:59.818705+0800 buddhismYDniu[1990:438359]     fontName = Verdana
 2018-07-04 10:30:59.818752+0800 buddhismYDniu[1990:438359]     fontName = Verdana-Bold
 2018-07-04 10:30:59.818885+0800 buddhismYDniu[1990:438359] familyName = Zapf Dingbats
 2018-07-04 10:30:59.820458+0800 buddhismYDniu[1990:438359]     fontName = ZapfDingbatsITC
 2018-07-04 10:30:59.820518+0800 buddhismYDniu[1990:438359] familyName = Avenir Next Condensed
 2018-07-04 10:30:59.820663+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-Regular
 2018-07-04 10:30:59.820714+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-MediumItalic
 2018-07-04 10:30:59.820762+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-UltraLightItalic
 2018-07-04 10:30:59.820811+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-UltraLight
 2018-07-04 10:30:59.820860+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-BoldItalic
 2018-07-04 10:30:59.820908+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-Italic
 2018-07-04 10:30:59.820955+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-Medium
 2018-07-04 10:30:59.821002+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-HeavyItalic
 2018-07-04 10:30:59.823175+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-Heavy
 2018-07-04 10:30:59.823230+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-DemiBoldItalic
 2018-07-04 10:30:59.823303+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-DemiBold
 2018-07-04 10:30:59.823353+0800 buddhismYDniu[1990:438359]     fontName = AvenirNextCondensed-Bold
 2018-07-04 10:30:59.823421+0800 buddhismYDniu[1990:438359] familyName = Courier
 2018-07-04 10:30:59.823539+0800 buddhismYDniu[1990:438359]     fontName = Courier
 2018-07-04 10:30:59.823588+0800 buddhismYDniu[1990:438359]     fontName = Courier-Oblique
 2018-07-04 10:30:59.823635+0800 buddhismYDniu[1990:438359]     fontName = Courier-BoldOblique
 2018-07-04 10:30:59.823682+0800 buddhismYDniu[1990:438359]     fontName = Courier-Bold
 2018-07-04 10:30:59.823733+0800 buddhismYDniu[1990:438359] familyName = Hoefler Text
 2018-07-04 10:30:59.823844+0800 buddhismYDniu[1990:438359]     fontName = HoeflerText-Regular
 2018-07-04 10:30:59.823981+0800 buddhismYDniu[1990:438359]     fontName = HoeflerText-BlackItalic
 2018-07-04 10:30:59.824035+0800 buddhismYDniu[1990:438359]     fontName = HoeflerText-Italic
 2018-07-04 10:30:59.824084+0800 buddhismYDniu[1990:438359]     fontName = HoeflerText-Black
 2018-07-04 10:30:59.824142+0800 buddhismYDniu[1990:438359] familyName = Euphemia UCAS
 2018-07-04 10:30:59.824253+0800 buddhismYDniu[1990:438359]     fontName = EuphemiaUCAS
 2018-07-04 10:30:59.824303+0800 buddhismYDniu[1990:438359]     fontName = EuphemiaUCAS-Bold
 2018-07-04 10:30:59.824430+0800 buddhismYDniu[1990:438359]     fontName = EuphemiaUCAS-Italic
 2018-07-04 10:30:59.824534+0800 buddhismYDniu[1990:438359] familyName = Helvetica
 2018-07-04 10:30:59.824767+0800 buddhismYDniu[1990:438359]     fontName = Helvetica-Oblique
 2018-07-04 10:30:59.824824+0800 buddhismYDniu[1990:438359]     fontName = Helvetica-Light
 2018-07-04 10:30:59.824913+0800 buddhismYDniu[1990:438359]     fontName = Helvetica-Bold
 2018-07-04 10:30:59.826043+0800 buddhismYDniu[1990:438359]     fontName = Helvetica
 2018-07-04 10:30:59.826219+0800 buddhismYDniu[1990:438359]     fontName = Helvetica-BoldOblique
 2018-07-04 10:30:59.826273+0800 buddhismYDniu[1990:438359]     fontName = Helvetica-LightOblique
 2018-07-04 10:30:59.826329+0800 buddhismYDniu[1990:438359] familyName = Lao Sangam MN
 2018-07-04 10:30:59.826441+0800 buddhismYDniu[1990:438359]     fontName = LaoSangamMN
 2018-07-04 10:30:59.826539+0800 buddhismYDniu[1990:438359] familyName = Hiragino Mincho ProN
 2018-07-04 10:30:59.826677+0800 buddhismYDniu[1990:438359]     fontName = HiraMinProN-W6
 2018-07-04 10:30:59.826753+0800 buddhismYDniu[1990:438359]     fontName = HiraMinProN-W3
 2018-07-04 10:30:59.826809+0800 buddhismYDniu[1990:438359] familyName = Bodoni Ornaments
 2018-07-04 10:30:59.826913+0800 buddhismYDniu[1990:438359]     fontName = BodoniOrnamentsITCTT
 2018-07-04 10:30:59.826970+0800 buddhismYDniu[1990:438359] familyName = Apple Color Emoji
 2018-07-04 10:30:59.827073+0800 buddhismYDniu[1990:438359]     fontName = AppleColorEmoji
 2018-07-04 10:30:59.830232+0800 buddhismYDniu[1990:438359] familyName = Mishafi
 2018-07-04 10:30:59.830368+0800 buddhismYDniu[1990:438359]     fontName = DiwanMishafi
 2018-07-04 10:30:59.830427+0800 buddhismYDniu[1990:438359] familyName = Optima
 2018-07-04 10:30:59.830545+0800 buddhismYDniu[1990:438359]     fontName = Optima-Regular
 2018-07-04 10:30:59.830595+0800 buddhismYDniu[1990:438359]     fontName = Optima-Italic
 2018-07-04 10:30:59.830643+0800 buddhismYDniu[1990:438359]     fontName = Optima-Bold
 2018-07-04 10:30:59.830690+0800 buddhismYDniu[1990:438359]     fontName = Optima-BoldItalic
 2018-07-04 10:30:59.830738+0800 buddhismYDniu[1990:438359]     fontName = Optima-ExtraBlack
 2018-07-04 10:30:59.830797+0800 buddhismYDniu[1990:438359] familyName = Gujarati Sangam MN
 2018-07-04 10:30:59.830975+0800 buddhismYDniu[1990:438359]     fontName = GujaratiSangamMN-Bold
 2018-07-04 10:30:59.831036+0800 buddhismYDniu[1990:438359]     fontName = GujaratiSangamMN
 2018-07-04 10:30:59.831091+0800 buddhismYDniu[1990:438359] familyName = Devanagari Sangam MN
 2018-07-04 10:30:59.832619+0800 buddhismYDniu[1990:438359]     fontName = DevanagariSangamMN
 2018-07-04 10:30:59.832677+0800 buddhismYDniu[1990:438359]     fontName = DevanagariSangamMN-Bold
 2018-07-04 10:30:59.832730+0800 buddhismYDniu[1990:438359] familyName = PingFang SC
 2018-07-04 10:30:59.832855+0800 buddhismYDniu[1990:438359]     fontName = PingFangSC-Semibold
 2018-07-04 10:30:59.832904+0800 buddhismYDniu[1990:438359]     fontName = PingFangSC-Regular
 2018-07-04 10:30:59.832952+0800 buddhismYDniu[1990:438359]     fontName = PingFangSC-Thin
 2018-07-04 10:30:59.832998+0800 buddhismYDniu[1990:438359]     fontName = PingFangSC-Light
 2018-07-04 10:30:59.833045+0800 buddhismYDniu[1990:438359]     fontName = PingFangSC-Ultralight
 2018-07-04 10:30:59.833092+0800 buddhismYDniu[1990:438359]     fontName = PingFangSC-Medium
 2018-07-04 10:30:59.833152+0800 buddhismYDniu[1990:438359] familyName = Savoye LET
 2018-07-04 10:30:59.833254+0800 buddhismYDniu[1990:438359]     fontName = SavoyeLetPlain
 2018-07-04 10:30:59.835541+0800 buddhismYDniu[1990:438359] familyName = Times New Roman
 2018-07-04 10:30:59.835702+0800 buddhismYDniu[1990:438359]     fontName = TimesNewRomanPS-BoldItalicMT
 2018-07-04 10:30:59.835754+0800 buddhismYDniu[1990:438359]     fontName = TimesNewRomanPSMT
 2018-07-04 10:30:59.835801+0800 buddhismYDniu[1990:438359]     fontName = TimesNewRomanPS-BoldMT
 2018-07-04 10:30:59.835849+0800 buddhismYDniu[1990:438359]     fontName = TimesNewRomanPS-ItalicMT
 2018-07-04 10:30:59.835900+0800 buddhismYDniu[1990:438359] familyName = Kailasa
 2018-07-04 10:30:59.836002+0800 buddhismYDniu[1990:438359]     fontName = Kailasa
 2018-07-04 10:30:59.836051+0800 buddhismYDniu[1990:438359]     fontName = Kailasa-Bold
 2018-07-04 10:30:59.836102+0800 buddhismYDniu[1990:438359] familyName = Telugu Sangam MN
 2018-07-04 10:30:59.836200+0800 buddhismYDniu[1990:438359] familyName = Heiti SC
 2018-07-04 10:30:59.836300+0800 buddhismYDniu[1990:438359] familyName = Apple SD Gothic Neo
 2018-07-04 10:30:59.838594+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-Thin
 2018-07-04 10:30:59.838651+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-UltraLight
 2018-07-04 10:30:59.838699+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-SemiBold
 2018-07-04 10:30:59.838746+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-Medium
 2018-07-04 10:30:59.838792+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-Regular
 2018-07-04 10:30:59.838838+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-Bold
 2018-07-04 10:30:59.838885+0800 buddhismYDniu[1990:438359]     fontName = AppleSDGothicNeo-Light
 2018-07-04 10:30:59.838945+0800 buddhismYDniu[1990:438359] familyName = Futura
 2018-07-04 10:30:59.839060+0800 buddhismYDniu[1990:438359]     fontName = Futura-Medium
 2018-07-04 10:30:59.839109+0800 buddhismYDniu[1990:438359]     fontName = Futura-CondensedMedium
 2018-07-04 10:30:59.839157+0800 buddhismYDniu[1990:438359]     fontName = Futura-Bold
 2018-07-04 10:30:59.841330+0800 buddhismYDniu[1990:438359]     fontName = Futura-MediumItalic
 2018-07-04 10:30:59.841390+0800 buddhismYDniu[1990:438359]     fontName = Futura-CondensedExtraBold
 2018-07-04 10:30:59.841472+0800 buddhismYDniu[1990:438359] familyName = Bodoni 72
 2018-07-04 10:30:59.841590+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoITCTT-Book
 2018-07-04 10:30:59.841642+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoITCTT-Bold
 2018-07-04 10:30:59.841689+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoITCTT-BookIta
 2018-07-04 10:30:59.841745+0800 buddhismYDniu[1990:438359] familyName = Baskerville
 2018-07-04 10:30:59.841863+0800 buddhismYDniu[1990:438359]     fontName = Baskerville-Bold
 2018-07-04 10:30:59.841915+0800 buddhismYDniu[1990:438359]     fontName = Baskerville-SemiBoldItalic
 2018-07-04 10:30:59.842011+0800 buddhismYDniu[1990:438359]     fontName = Baskerville-BoldItalic
 2018-07-04 10:30:59.842063+0800 buddhismYDniu[1990:438359]     fontName = Baskerville
 2018-07-04 10:30:59.842112+0800 buddhismYDniu[1990:438359]     fontName = Baskerville-SemiBold
 2018-07-04 10:30:59.843549+0800 buddhismYDniu[1990:438359]     fontName = Baskerville-Italic
 2018-07-04 10:30:59.843630+0800 buddhismYDniu[1990:438359] familyName = Symbol
 2018-07-04 10:30:59.843742+0800 buddhismYDniu[1990:438359]     fontName = Symbol
 2018-07-04 10:30:59.843830+0800 buddhismYDniu[1990:438359] familyName = Heiti TC
 2018-07-04 10:30:59.843935+0800 buddhismYDniu[1990:438359] familyName = Copperplate
 2018-07-04 10:30:59.844050+0800 buddhismYDniu[1990:438359]     fontName = Copperplate
 2018-07-04 10:30:59.844100+0800 buddhismYDniu[1990:438359]     fontName = Copperplate-Light
 2018-07-04 10:30:59.844147+0800 buddhismYDniu[1990:438359]     fontName = Copperplate-Bold
 2018-07-04 10:30:59.844202+0800 buddhismYDniu[1990:438359] familyName = Party LET
 2018-07-04 10:30:59.844302+0800 buddhismYDniu[1990:438359]     fontName = PartyLetPlain
 2018-07-04 10:30:59.844356+0800 buddhismYDniu[1990:438359] familyName = American Typewriter
 2018-07-04 10:30:59.844622+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter-Semibold
 2018-07-04 10:30:59.844678+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter-Light
 2018-07-04 10:30:59.844727+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter-CondensedLight
 2018-07-04 10:30:59.844776+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter-CondensedBold
 2018-07-04 10:30:59.844825+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter
 2018-07-04 10:30:59.844873+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter-Condensed
 2018-07-04 10:30:59.845008+0800 buddhismYDniu[1990:438359]     fontName = AmericanTypewriter-Bold
 2018-07-04 10:30:59.845118+0800 buddhismYDniu[1990:438359] familyName = Chalkboard SE
 2018-07-04 10:30:59.845353+0800 buddhismYDniu[1990:438359]     fontName = ChalkboardSE-Light
 2018-07-04 10:30:59.845408+0800 buddhismYDniu[1990:438359]     fontName = ChalkboardSE-Regular
 2018-07-04 10:30:59.845498+0800 buddhismYDniu[1990:438359]     fontName = ChalkboardSE-Bold
 2018-07-04 10:30:59.846650+0800 buddhismYDniu[1990:438359] familyName = Avenir Next
 2018-07-04 10:30:59.846804+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-MediumItalic
 2018-07-04 10:30:59.846856+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-Bold
 2018-07-04 10:30:59.846904+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-UltraLight
 2018-07-04 10:30:59.846952+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-DemiBold
 2018-07-04 10:30:59.847000+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-HeavyItalic
 2018-07-04 10:30:59.847048+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-Heavy
 2018-07-04 10:30:59.847096+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-Medium
 2018-07-04 10:30:59.847178+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-Italic
 2018-07-04 10:30:59.847261+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-UltraLightItalic
 2018-07-04 10:30:59.847312+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-BoldItalic
 2018-07-04 10:30:59.848941+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-Regular
 2018-07-04 10:30:59.849106+0800 buddhismYDniu[1990:438359]     fontName = AvenirNext-DemiBoldItalic
 2018-07-04 10:30:59.849177+0800 buddhismYDniu[1990:438359] familyName = Bangla Sangam MN
 2018-07-04 10:30:59.849404+0800 buddhismYDniu[1990:438359] familyName = Noteworthy
 2018-07-04 10:30:59.849519+0800 buddhismYDniu[1990:438359]     fontName = Noteworthy-Bold
 2018-07-04 10:30:59.849670+0800 buddhismYDniu[1990:438359]     fontName = Noteworthy-Light
 2018-07-04 10:30:59.849726+0800 buddhismYDniu[1990:438359] familyName = Hiragino Sans
 2018-07-04 10:30:59.849896+0800 buddhismYDniu[1990:438359]     fontName = HiraginoSans-W6
 2018-07-04 10:30:59.849974+0800 buddhismYDniu[1990:438359]     fontName = HiraginoSans-W3
 2018-07-04 10:30:59.850032+0800 buddhismYDniu[1990:438359] familyName = Zapfino
 2018-07-04 10:30:59.850136+0800 buddhismYDniu[1990:438359]     fontName = Zapfino
 2018-07-04 10:30:59.850190+0800 buddhismYDniu[1990:438359] familyName = Myanmar Sangam MN
 2018-07-04 10:30:59.851151+0800 buddhismYDniu[1990:438359]     fontName = MyanmarSangamMN
 2018-07-04 10:30:59.851320+0800 buddhismYDniu[1990:438359]     fontName = MyanmarSangamMN-Bold
 2018-07-04 10:30:59.851378+0800 buddhismYDniu[1990:438359] familyName = Tamil Sangam MN
 2018-07-04 10:30:59.851488+0800 buddhismYDniu[1990:438359]     fontName = TamilSangamMN
 2018-07-04 10:30:59.851583+0800 buddhismYDniu[1990:438359]     fontName = TamilSangamMN-Bold
 2018-07-04 10:30:59.851638+0800 buddhismYDniu[1990:438359] familyName = Arial Hebrew
 2018-07-04 10:30:59.851750+0800 buddhismYDniu[1990:438359]     fontName = ArialHebrew-Bold
 2018-07-04 10:30:59.851801+0800 buddhismYDniu[1990:438359]     fontName = ArialHebrew-Light
 2018-07-04 10:30:59.851849+0800 buddhismYDniu[1990:438359]     fontName = ArialHebrew
 2018-07-04 10:30:59.851903+0800 buddhismYDniu[1990:438359] familyName = Chalkduster
 2018-07-04 10:30:59.852005+0800 buddhismYDniu[1990:438359]     fontName = Chalkduster
 2018-07-04 10:30:59.855497+0800 buddhismYDniu[1990:438359] familyName = Georgia
 2018-07-04 10:30:59.855639+0800 buddhismYDniu[1990:438359]     fontName = Georgia-BoldItalic
 2018-07-04 10:30:59.855690+0800 buddhismYDniu[1990:438359]     fontName = Georgia-Bold
 2018-07-04 10:30:59.855740+0800 buddhismYDniu[1990:438359]     fontName = Georgia-Italic
 2018-07-04 10:30:59.855786+0800 buddhismYDniu[1990:438359]     fontName = Georgia
 2018-07-04 10:30:59.855838+0800 buddhismYDniu[1990:438359] familyName = Helvetica Neue
 2018-07-04 10:30:59.855978+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-BoldItalic
 2018-07-04 10:30:59.856030+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-Light
 2018-07-04 10:30:59.856078+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-Italic
 2018-07-04 10:30:59.856126+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-UltraLightItalic
 2018-07-04 10:30:59.856175+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-CondensedBold
 2018-07-04 10:30:59.856223+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-MediumItalic
 2018-07-04 10:30:59.858158+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-Thin
 2018-07-04 10:30:59.858218+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-Medium
 2018-07-04 10:30:59.858291+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-ThinItalic
 2018-07-04 10:30:59.858339+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-UltraLight
 2018-07-04 10:30:59.858412+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-LightItalic
 2018-07-04 10:30:59.858462+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-Bold
 2018-07-04 10:30:59.858510+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue
 2018-07-04 10:30:59.858557+0800 buddhismYDniu[1990:438359]     fontName = HelveticaNeue-CondensedBlack
 2018-07-04 10:30:59.858613+0800 buddhismYDniu[1990:438359] familyName = Gill Sans
 2018-07-04 10:30:59.858789+0800 buddhismYDniu[1990:438359]     fontName = GillSans
 2018-07-04 10:30:59.858853+0800 buddhismYDniu[1990:438359]     fontName = GillSans-SemiBoldItalic
 2018-07-04 10:30:59.860408+0800 buddhismYDniu[1990:438359]     fontName = GillSans-Italic
 2018-07-04 10:30:59.860463+0800 buddhismYDniu[1990:438359]     fontName = GillSans-BoldItalic
 2018-07-04 10:30:59.860512+0800 buddhismYDniu[1990:438359]     fontName = GillSans-Light
 2018-07-04 10:30:59.860559+0800 buddhismYDniu[1990:438359]     fontName = GillSans-LightItalic
 2018-07-04 10:30:59.860608+0800 buddhismYDniu[1990:438359]     fontName = GillSans-UltraBold
 2018-07-04 10:30:59.860655+0800 buddhismYDniu[1990:438359]     fontName = GillSans-Bold
 2018-07-04 10:30:59.860702+0800 buddhismYDniu[1990:438359]     fontName = GillSans-SemiBold
 2018-07-04 10:30:59.860766+0800 buddhismYDniu[1990:438359] familyName = Kohinoor Devanagari
 2018-07-04 10:30:59.860892+0800 buddhismYDniu[1990:438359]     fontName = KohinoorDevanagari-Regular
 2018-07-04 10:30:59.860943+0800 buddhismYDniu[1990:438359]     fontName = KohinoorDevanagari-Light
 2018-07-04 10:30:59.860990+0800 buddhismYDniu[1990:438359]     fontName = KohinoorDevanagari-Semibold
 2018-07-04 10:30:59.863171+0800 buddhismYDniu[1990:438359] familyName = Palatino
 2018-07-04 10:30:59.863295+0800 buddhismYDniu[1990:438359]     fontName = Palatino-Roman
 2018-07-04 10:30:59.863345+0800 buddhismYDniu[1990:438359]     fontName = Palatino-Italic
 2018-07-04 10:30:59.863393+0800 buddhismYDniu[1990:438359]     fontName = Palatino-Bold
 2018-07-04 10:30:59.863440+0800 buddhismYDniu[1990:438359]     fontName = Palatino-BoldItalic
 2018-07-04 10:30:59.863490+0800 buddhismYDniu[1990:438359] familyName = Courier New
 2018-07-04 10:30:59.863601+0800 buddhismYDniu[1990:438359]     fontName = CourierNewPSMT
 2018-07-04 10:30:59.863649+0800 buddhismYDniu[1990:438359]     fontName = CourierNewPS-BoldMT
 2018-07-04 10:30:59.863696+0800 buddhismYDniu[1990:438359]     fontName = CourierNewPS-ItalicMT
 2018-07-04 10:30:59.863743+0800 buddhismYDniu[1990:438359]     fontName = CourierNewPS-BoldItalicMT
 2018-07-04 10:30:59.863794+0800 buddhismYDniu[1990:438359] familyName = Oriya Sangam MN
 2018-07-04 10:30:59.866038+0800 buddhismYDniu[1990:438359]     fontName = OriyaSangamMN
 2018-07-04 10:30:59.866096+0800 buddhismYDniu[1990:438359]     fontName = OriyaSangamMN-Bold
 2018-07-04 10:30:59.866150+0800 buddhismYDniu[1990:438359] familyName = Didot
 2018-07-04 10:30:59.866259+0800 buddhismYDniu[1990:438359]     fontName = Didot-Bold
 2018-07-04 10:30:59.866308+0800 buddhismYDniu[1990:438359]     fontName = Didot-Italic
 2018-07-04 10:30:59.866355+0800 buddhismYDniu[1990:438359]     fontName = Didot
 2018-07-04 10:30:59.866409+0800 buddhismYDniu[1990:438359] familyName = PingFang TC
 2018-07-04 10:30:59.866530+0800 buddhismYDniu[1990:438359]     fontName = PingFangTC-Regular
 2018-07-04 10:30:59.866580+0800 buddhismYDniu[1990:438359]     fontName = PingFangTC-Semibold
 2018-07-04 10:30:59.866627+0800 buddhismYDniu[1990:438359]     fontName = PingFangTC-Medium
 2018-07-04 10:30:59.866673+0800 buddhismYDniu[1990:438359]     fontName = PingFangTC-Thin
 2018-07-04 10:30:59.866720+0800 buddhismYDniu[1990:438359]     fontName = PingFangTC-Ultralight
 2018-07-04 10:30:59.866870+0800 buddhismYDniu[1990:438359]     fontName = PingFangTC-Light
 2018-07-04 10:30:59.866937+0800 buddhismYDniu[1990:438359] familyName = Bodoni 72 Smallcaps
 2018-07-04 10:30:59.867045+0800 buddhismYDniu[1990:438359]     fontName = BodoniSvtyTwoSCITCTT-Book
 
 */


   //获取字体名字
//for(NSString *familyName in [UIFont familyNames])
//{
//    NSLog(@"familyName = %@", familyName);
//
//    for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName])
//    {
//        NSLog(@"\tfontName = %@", fontName);
//    }
//}

#ifndef BaseFont_h
#define BaseFont_h


#define BaseFont14 [UIFont systemFontOfSize:14.f]
#define BaseFont16 [UIFont systemFontOfSize:16.f]
#define BaseFont18 [UIFont systemFontOfSize:18.f]
#define BaseFont20 [UIFont systemFontOfSize:20.f]


#define BaseIsIPHONE5BaseMailFont16        IS_IPHONE5 ? font(14.f) : font(16.f)
#define BaseIsIPHONE5BaseMailFont18        IS_IPHONE5 ? font(16.f) : font(18.f)

#define RTIsIPHONE5BaseMailFont16       IS_IPHONE5 ? RTFont(15.f) : RTFont(16.f)
///otherFont(@"MarkerFelt-Wide", 18)金额
#define otherFont(other,a)  [UIFont fontWithName:other size:a]
#define HNW3Font(a)  [UIFont fontWithName:@"HiraMinProN-W3" size:a]
#define HNW6Font(a)  [UIFont fontWithName:@"HiraMinProN-W6" size:a]
#define RTFont(a)  [UIFont fontWithName:@"Roboto-Thin" size:a] //细体
#define jsFont(a)  [UIFont fontWithName:@"Helvetica-Bold" size:a] //加粗 HiraMinProN-W3
//Helvetica-Bold .SFUIText-Regular
#define font(a)  [UIFont systemFontOfSize:a]
#define boldFont(a) [UIFont boldSystemFontOfSize:a]

#endif /* BaseFont_h */
