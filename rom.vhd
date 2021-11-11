library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY ROM IS
	PORT (
		address 	: 	IN 	STD_LOGIC_VECTOR(7 downto 0);
		data 		: 	OUT 	STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY;

ARCHITECTURE RTL OF ROM IS
	TYPE mem IS ARRAY(0 to 2**8 - 1) OF STD_LOGIC_VECTOR(7 downto 0);
  
	CONSTANT my_Rom : mem := (
		0	 => "10101100", -- BEQ R2, R3, 00 (not taken)
		1   => "00010100", -- POSICAO BEQ (linha 20)
		2   => "00111011", -- ADD R3, R3, R2 (Realiza a soma) -- resultado R3 = 1111 0000 = 240
		3   => "10000100", -- BEQ R0, R1, 00 (taken)
		4   => "00010100", -- POSICAO BEQ (linha 20)
		5   => "ZZZZZZZZ",
		6   => "ZZZZZZZZ",
		7   => "ZZZZZZZZ",
		8   => "ZZZZZZZZ",
		9   => "ZZZZZZZZ",
		10  => "ZZZZZZZZ",
		11  => "ZZZZZZZZ",
		12  => "ZZZZZZZZ",
		13  => "ZZZZZZZZ",
		14  => "ZZZZZZZZ",
		15  => "ZZZZZZZZ",
		16	 => "ZZZZZZZZ",
		17  => "ZZZZZZZZ",
		18  => "ZZZZZZZZ",
		19  => "ZZZZZZZZ",
		20  => "01100110", -- SUB R2, R2, R1 (Realiza a subtracao) -- resultado R2 = 0010 1101 = 45
		21  => "11011001", -- JMP 25 (Realiza o JMP)
		22  => "00111011", -- ADD R3, R3, R2 (Não realiza a operação)
		23  => "ZZZZZZZZ",
		24  => "ZZZZZZZZ",
		25  => "01100111", -- SUB R3, R2, R1 (Realiza a subtracao) -- resultado R3 = 0010 1010 = 42
		26  => "ZZZZZZZZ",
		27  => "ZZZZZZZZ",
		28  => "ZZZZZZZZ",
		29  => "ZZZZZZZZ",
		30  => "ZZZZZZZZ",
		31  => "ZZZZZZZZ",
		32	 => "ZZZZZZZZ",
		33  => "ZZZZZZZZ",
		34  => "ZZZZZZZZ",
		35  => "ZZZZZZZZ",
		36  => "ZZZZZZZZ",
		37  => "ZZZZZZZZ",
		38  => "ZZZZZZZZ",
		39  => "ZZZZZZZZ",
		40  => "ZZZZZZZZ",
		41  => "ZZZZZZZZ",
		42  => "ZZZZZZZZ",
		43  => "ZZZZZZZZ",
		44  => "ZZZZZZZZ",
		45  => "ZZZZZZZZ",
		46  => "ZZZZZZZZ",
		47  => "ZZZZZZZZ",
		48  => "ZZZZZZZZ",
		49  => "ZZZZZZZZ",
		50  => "ZZZZZZZZ",
		51  => "ZZZZZZZZ",
		52  => "ZZZZZZZZ",
		53  => "ZZZZZZZZ",
		54  => "ZZZZZZZZ",
		55  => "ZZZZZZZZ",
		56  => "ZZZZZZZZ",
		57  => "ZZZZZZZZ",
		58  => "ZZZZZZZZ",
		59  => "ZZZZZZZZ",
		60  => "ZZZZZZZZ",
		61  => "ZZZZZZZZ",
		62  => "ZZZZZZZZ",
		63  => "ZZZZZZZZ",
		64	 => "ZZZZZZZZ",
		65  => "ZZZZZZZZ",
		66  => "ZZZZZZZZ",
		67  => "ZZZZZZZZ",
		68  => "ZZZZZZZZ",
		69  => "ZZZZZZZZ",
		70  => "ZZZZZZZZ",
		71  => "ZZZZZZZZ",
		72  => "ZZZZZZZZ",
		73  => "ZZZZZZZZ",
		74  => "ZZZZZZZZ",
		75  => "ZZZZZZZZ",
		76  => "ZZZZZZZZ",
		77  => "ZZZZZZZZ",
		78  => "ZZZZZZZZ",
		79  => "ZZZZZZZZ",
		80	 => "ZZZZZZZZ",
		81  => "ZZZZZZZZ",
		82  => "ZZZZZZZZ",
		83  => "ZZZZZZZZ",
		84  => "ZZZZZZZZ",
		85  => "ZZZZZZZZ",
		86  => "ZZZZZZZZ",
		87  => "ZZZZZZZZ",
		88  => "ZZZZZZZZ",
		89  => "ZZZZZZZZ",
		90  => "ZZZZZZZZ",
		91  => "ZZZZZZZZ",
		92  => "ZZZZZZZZ",
		93  => "ZZZZZZZZ",
		94  => "ZZZZZZZZ",
		95  => "ZZZZZZZZ",
		96  => "ZZZZZZZZ",
		97  => "ZZZZZZZZ",
		98  => "ZZZZZZZZ",
		99  => "ZZZZZZZZ",
		100 => "ZZZZZZZZ",
		101 => "ZZZZZZZZ",
		102 => "ZZZZZZZZ",
		103 => "ZZZZZZZZ",
		104 => "ZZZZZZZZ",
		105 => "ZZZZZZZZ",
		106 => "ZZZZZZZZ",
		107 => "ZZZZZZZZ",
		108 => "ZZZZZZZZ",
		109 => "ZZZZZZZZ",
		110 => "ZZZZZZZZ",
		111 => "ZZZZZZZZ",
		112 => "ZZZZZZZZ",
		113 => "ZZZZZZZZ",
		114 => "ZZZZZZZZ",
		115 => "ZZZZZZZZ",
		116 => "ZZZZZZZZ",
		117 => "ZZZZZZZZ",
		118 => "ZZZZZZZZ",
		119 => "ZZZZZZZZ",
		120 => "ZZZZZZZZ",
		121 => "ZZZZZZZZ",
		122 => "ZZZZZZZZ",
		123 => "ZZZZZZZZ",
		124 => "ZZZZZZZZ",
		125 => "ZZZZZZZZ",
		126 => "ZZZZZZZZ",
		127 => "ZZZZZZZZ",
		128 => "ZZZZZZZZ",
		129 => "ZZZZZZZZ",
		130 => "ZZZZZZZZ",
		131 => "ZZZZZZZZ",
		132 => "ZZZZZZZZ",
		133 => "ZZZZZZZZ",
		134 => "ZZZZZZZZ",
		135 => "ZZZZZZZZ",
		136 => "ZZZZZZZZ",
		137 => "ZZZZZZZZ",
		138 => "ZZZZZZZZ",
		139 => "ZZZZZZZZ",
		140 => "ZZZZZZZZ",
		141 => "ZZZZZZZZ",
		142 => "ZZZZZZZZ",
		143 => "ZZZZZZZZ",
		144 => "ZZZZZZZZ",
		145 => "ZZZZZZZZ",
		146 => "ZZZZZZZZ",
		147 => "ZZZZZZZZ",
		148 => "ZZZZZZZZ",
		149 => "ZZZZZZZZ",
		150 => "ZZZZZZZZ",
		151 => "ZZZZZZZZ",
		152 => "ZZZZZZZZ",
		153 => "ZZZZZZZZ",
		154 => "ZZZZZZZZ",
		155 => "ZZZZZZZZ",
		156 => "ZZZZZZZZ",
		157 => "ZZZZZZZZ",
		158 => "ZZZZZZZZ",
		159 => "ZZZZZZZZ",
		160 => "ZZZZZZZZ",
		161 => "ZZZZZZZZ",
		162 => "ZZZZZZZZ",
		163 => "ZZZZZZZZ",
		164 => "ZZZZZZZZ",
		165 => "ZZZZZZZZ",
		166 => "ZZZZZZZZ",
		167 => "ZZZZZZZZ",
		168 => "ZZZZZZZZ",
		169 => "ZZZZZZZZ",
		170 => "ZZZZZZZZ",
		171 => "ZZZZZZZZ",
		172 => "ZZZZZZZZ",
		173 => "ZZZZZZZZ",
		174 => "ZZZZZZZZ",
		175 => "ZZZZZZZZ",
		176 => "ZZZZZZZZ",
		177 => "ZZZZZZZZ",
		178 => "ZZZZZZZZ",
		179 => "ZZZZZZZZ",
		180 => "ZZZZZZZZ",
		181 => "ZZZZZZZZ",
		182 => "ZZZZZZZZ",
		183 => "ZZZZZZZZ",
		184 => "ZZZZZZZZ",
		185 => "ZZZZZZZZ",
		186 => "ZZZZZZZZ",
		187 => "ZZZZZZZZ",
		188 => "ZZZZZZZZ",
		189 => "ZZZZZZZZ",
		190 => "ZZZZZZZZ",
		191 => "ZZZZZZZZ",
		192 => "ZZZZZZZZ",
		193 => "ZZZZZZZZ",
		194 => "ZZZZZZZZ",
		195 => "ZZZZZZZZ",
		196 => "ZZZZZZZZ",
		197 => "ZZZZZZZZ",
		198 => "ZZZZZZZZ",
		199 => "ZZZZZZZZ",
		200 => "ZZZZZZZZ",
		201 => "ZZZZZZZZ",
		202 => "ZZZZZZZZ",
		203 => "ZZZZZZZZ",
		204 => "ZZZZZZZZ",
		205 => "ZZZZZZZZ",
		206 => "ZZZZZZZZ",
		207 => "ZZZZZZZZ",
		208 => "ZZZZZZZZ",
		209 => "ZZZZZZZZ",
		210 => "ZZZZZZZZ",
		211 => "ZZZZZZZZ",
		212 => "ZZZZZZZZ",
		213 => "ZZZZZZZZ",
		214 => "ZZZZZZZZ",
		215 => "ZZZZZZZZ",
		216 => "ZZZZZZZZ",
		217 => "ZZZZZZZZ",
		218 => "ZZZZZZZZ",
		219 => "ZZZZZZZZ",
		220 => "ZZZZZZZZ",
		221 => "ZZZZZZZZ",
		222 => "ZZZZZZZZ",
		223 => "ZZZZZZZZ",
		224 => "ZZZZZZZZ",
		225 => "ZZZZZZZZ",
		226 => "ZZZZZZZZ",
		227 => "ZZZZZZZZ",
		228 => "ZZZZZZZZ",
		229 => "ZZZZZZZZ",
		230 => "ZZZZZZZZ",
		231 => "ZZZZZZZZ",
		232 => "ZZZZZZZZ",
		233 => "ZZZZZZZZ",
		234 => "ZZZZZZZZ",
		235 => "ZZZZZZZZ",
		236 => "ZZZZZZZZ",
		237 => "ZZZZZZZZ",
		238 => "ZZZZZZZZ",
		239 => "ZZZZZZZZ",
		240 => "ZZZZZZZZ",
		241 => "ZZZZZZZZ",
		242 => "ZZZZZZZZ",
		243 => "ZZZZZZZZ",
		244 => "ZZZZZZZZ",
		245 => "ZZZZZZZZ",
		246 => "ZZZZZZZZ",
		247 => "ZZZZZZZZ",
		248 => "ZZZZZZZZ",
		249 => "ZZZZZZZZ",
		250 => "ZZZZZZZZ",
		251 => "ZZZZZZZZ",
		252 => "ZZZZZZZZ",
		253 => "ZZZZZZZZ",
		254 => "ZZZZZZZZ",
		255 => "ZZZZZZZZ"
	);
	
BEGIN

	PROCESS (address)
	BEGIN
		CASE address IS
			WHEN "00000000" => data <= my_rom(0);
			WHEN "00000001" => data <= my_rom(1);
			WHEN "00000010" => data <= my_rom(2);
			WHEN "00000011" => data <= my_rom(3);
			WHEN "00000100" => data <= my_rom(4);
			WHEN "00000101" => data <= my_rom(5);
			WHEN "00000110" => data <= my_rom(6);
			WHEN "00000111" => data <= my_rom(7);
			WHEN "00001000" => data <= my_rom(8);
			WHEN "00001001" => data <= my_rom(9);
			WHEN "00001010" => data <= my_rom(10);
			WHEN "00001011" => data <= my_rom(11);
			WHEN "00001100" => data <= my_rom(12);
			WHEN "00001101" => data <= my_rom(13);
			WHEN "00001110" => data <= my_rom(14);
			WHEN "00001111" => data <= my_rom(15);
			WHEN "00010000" => data <= my_rom(16);
			WHEN "00010001" => data <= my_rom(17);
			WHEN "00010010" => data <= my_rom(18);
			WHEN "00010011" => data <= my_rom(19);
			WHEN "00010100" => data <= my_rom(20);
			WHEN "00010101" => data <= my_rom(21);
			WHEN "00010110" => data <= my_rom(22);
			WHEN "00010111" => data <= my_rom(23);
			WHEN "00011000" => data <= my_rom(24);
			WHEN "00011001" => data <= my_rom(25);
			WHEN "00011010" => data <= my_rom(26);
			WHEN "00011011" => data <= my_rom(27);
			WHEN "00011100" => data <= my_rom(28);
			WHEN "00011101" => data <= my_rom(29);
			WHEN "00011110" => data <= my_rom(30);
			WHEN "00011111" => data <= my_rom(31);
			WHEN "00100000" => data <= my_rom(32);
			WHEN "00100001" => data <= my_rom(33);
			WHEN "00100010" => data <= my_rom(34);
			WHEN "00100011" => data <= my_rom(35);
			WHEN "00100100" => data <= my_rom(36);
			WHEN "00100101" => data <= my_rom(37);
			WHEN "00100110" => data <= my_rom(38);
			WHEN "00100111" => data <= my_rom(39);
			WHEN "00101000" => data <= my_rom(40);
			WHEN "00101001" => data <= my_rom(41);
			WHEN "00101010" => data <= my_rom(42);
			WHEN "00101011" => data <= my_rom(43);
			WHEN "00101100" => data <= my_rom(44);
			WHEN "00101101" => data <= my_rom(45);
			WHEN "00101110" => data <= my_rom(46);
			WHEN "00101111" => data <= my_rom(47);
			WHEN "00110000" => data <= my_rom(48);
			WHEN "00110001" => data <= my_rom(49);
			WHEN "00110010" => data <= my_rom(50);
			WHEN "00110011" => data <= my_rom(51);
			WHEN "00110100" => data <= my_rom(52);
			WHEN "00110101" => data <= my_rom(53);
			WHEN "00110110" => data <= my_rom(54);
			WHEN "00110111" => data <= my_rom(55);
			WHEN "00111000" => data <= my_rom(56);
			WHEN "00111001" => data <= my_rom(57);
			WHEN "00111010" => data <= my_rom(58);
			WHEN "00111011" => data <= my_rom(59);
			WHEN "00111100" => data <= my_rom(60);
			WHEN "00111101" => data <= my_rom(61);
			WHEN "00111110" => data <= my_rom(62);
			WHEN "00111111" => data <= my_rom(63);
			WHEN "01000000" => data <= my_rom(64);
			WHEN "01000001" => data <= my_rom(65);
			WHEN "01000010" => data <= my_rom(66);
			WHEN "01000011" => data <= my_rom(67);
			WHEN "01000100" => data <= my_rom(68);
			WHEN "01000101" => data <= my_rom(69);
			WHEN "01000110" => data <= my_rom(70);
			WHEN "01000111" => data <= my_rom(71);
			WHEN "01001000" => data <= my_rom(72);
			WHEN "01001001" => data <= my_rom(73);
			WHEN "01001010" => data <= my_rom(74);
			WHEN "01001011" => data <= my_rom(75);
			WHEN "01001100" => data <= my_rom(76);
			WHEN "01001101" => data <= my_rom(77);
			WHEN "01001110" => data <= my_rom(78);
			WHEN "01001111" => data <= my_rom(79);
			WHEN "01010000" => data <= my_rom(80);
			WHEN "01010001" => data <= my_rom(81);
			WHEN "01010010" => data <= my_rom(82);
			WHEN "01010011" => data <= my_rom(83);
			WHEN "01010100" => data <= my_rom(84);
			WHEN "01010101" => data <= my_rom(85);
			WHEN "01010110" => data <= my_rom(86);
			WHEN "01010111" => data <= my_rom(87);
			WHEN "01011000" => data <= my_rom(88);
			WHEN "01011001" => data <= my_rom(89);
			WHEN "01011010" => data <= my_rom(90);
			WHEN "01011011" => data <= my_rom(91);
			WHEN "01011100" => data <= my_rom(92);
			WHEN "01011101" => data <= my_rom(93);
			WHEN "01011110" => data <= my_rom(94);
			WHEN "01011111" => data <= my_rom(95);
			WHEN "01100000" => data <= my_rom(96);
			WHEN "01100001" => data <= my_rom(97);
			WHEN "01100010" => data <= my_rom(98);
			WHEN "01100011" => data <= my_rom(99);
			WHEN "01100100" => data <= my_rom(100);
			WHEN "01100101" => data <= my_rom(101);
			WHEN "01100110" => data <= my_rom(102);
			WHEN "01100111" => data <= my_rom(103);
			WHEN "01101000" => data <= my_rom(104);
			WHEN "01101001" => data <= my_rom(105);
			WHEN "01101010" => data <= my_rom(106);
			WHEN "01101011" => data <= my_rom(107);
			WHEN "01101100" => data <= my_rom(108);
			WHEN "01101101" => data <= my_rom(109);
			WHEN "01101110" => data <= my_rom(110);
			WHEN "01101111" => data <= my_rom(111);
			WHEN "01110000" => data <= my_rom(112);
			WHEN "01110001" => data <= my_rom(113);
			WHEN "01110010" => data <= my_rom(114);
			WHEN "01110011" => data <= my_rom(115);
			WHEN "01110100" => data <= my_rom(116);
			WHEN "01110101" => data <= my_rom(117);
			WHEN "01110110" => data <= my_rom(118);
			WHEN "01110111" => data <= my_rom(119);
			WHEN "01111000" => data <= my_rom(120);
			WHEN "01111001" => data <= my_rom(121);
			WHEN "01111010" => data <= my_rom(122);
			WHEN "01111011" => data <= my_rom(123);
			WHEN "01111100" => data <= my_rom(124);
			WHEN "01111101" => data <= my_rom(125);
			WHEN "01111110" => data <= my_rom(126);
			WHEN "01111111" => data <= my_rom(127);
			WHEN "10000000" => data <= my_rom(128);
			WHEN "10000001" => data <= my_rom(129);
			WHEN "10000010" => data <= my_rom(130);
			WHEN "10000011" => data <= my_rom(131);
			WHEN "10000100" => data <= my_rom(132);
			WHEN "10000101" => data <= my_rom(133);
			WHEN "10000110" => data <= my_rom(134);
			WHEN "10000111" => data <= my_rom(135);
			WHEN "10001000" => data <= my_rom(136);
			WHEN "10001001" => data <= my_rom(137);
			WHEN "10001010" => data <= my_rom(138);
			WHEN "10001011" => data <= my_rom(139);
			WHEN "10001100" => data <= my_rom(140);
			WHEN "10001101" => data <= my_rom(141);
			WHEN "10001110" => data <= my_rom(142);
			WHEN "10001111" => data <= my_rom(143);
			WHEN "10010000" => data <= my_rom(144);
			WHEN "10010001" => data <= my_rom(145);
			WHEN "10010010" => data <= my_rom(146);
			WHEN "10010011" => data <= my_rom(147);
			WHEN "10010100" => data <= my_rom(148);
			WHEN "10010101" => data <= my_rom(149);
			WHEN "10010110" => data <= my_rom(150);
			WHEN "10010111" => data <= my_rom(151);
			WHEN "10011000" => data <= my_rom(152);
			WHEN "10011001" => data <= my_rom(153);
			WHEN "10011010" => data <= my_rom(154);
			WHEN "10011011" => data <= my_rom(155);
			WHEN "10011100" => data <= my_rom(156);
			WHEN "10011101" => data <= my_rom(157);
			WHEN "10011110" => data <= my_rom(158);
			WHEN "10011111" => data <= my_rom(159);
			WHEN "10100000" => data <= my_rom(160);
			WHEN "10100001" => data <= my_rom(161);
			WHEN "10100010" => data <= my_rom(162);
			WHEN "10100011" => data <= my_rom(163);
			WHEN "10100100" => data <= my_rom(164);
			WHEN "10100101" => data <= my_rom(165);
			WHEN "10100110" => data <= my_rom(166);
			WHEN "10100111" => data <= my_rom(167);
			WHEN "10101000" => data <= my_rom(168);
			WHEN "10101001" => data <= my_rom(169);
			WHEN "10101010" => data <= my_rom(170);
			WHEN "10101011" => data <= my_rom(171);
			WHEN "10101100" => data <= my_rom(172);
			WHEN "10101101" => data <= my_rom(173);
			WHEN "10101110" => data <= my_rom(174);
			WHEN "10101111" => data <= my_rom(175);
			WHEN "10110000" => data <= my_rom(176);
			WHEN "10110001" => data <= my_rom(177);
			WHEN "10110010" => data <= my_rom(178);
			WHEN "10110011" => data <= my_rom(179);
			WHEN "10110100" => data <= my_rom(180);
			WHEN "10110101" => data <= my_rom(181);
			WHEN "10110110" => data <= my_rom(182);
			WHEN "10110111" => data <= my_rom(183);
			WHEN "10111000" => data <= my_rom(184);
			WHEN "10111001" => data <= my_rom(185);
			WHEN "10111010" => data <= my_rom(186);
			WHEN "10111011" => data <= my_rom(187);
			WHEN "10111100" => data <= my_rom(188);
			WHEN "10111101" => data <= my_rom(189);
			WHEN "10111110" => data <= my_rom(190);
			WHEN "10111111" => data <= my_rom(191);
			WHEN "11000000" => data <= my_rom(192);
			WHEN "11000001" => data <= my_rom(193);
			WHEN "11000010" => data <= my_rom(194);
			WHEN "11000011" => data <= my_rom(195);
			WHEN "11000100" => data <= my_rom(196);
			WHEN "11000101" => data <= my_rom(197);
			WHEN "11000110" => data <= my_rom(198);
			WHEN "11000111" => data <= my_rom(199);
			WHEN "11001000" => data <= my_rom(200);
			WHEN "11001001" => data <= my_rom(201);
			WHEN "11001010" => data <= my_rom(202);
			WHEN "11001011" => data <= my_rom(203);
			WHEN "11001100" => data <= my_rom(204);
			WHEN "11001101" => data <= my_rom(205);
			WHEN "11001110" => data <= my_rom(206);
			WHEN "11001111" => data <= my_rom(207);
			WHEN "11010000" => data <= my_rom(208);
			WHEN "11010001" => data <= my_rom(209);
			WHEN "11010010" => data <= my_rom(210);
			WHEN "11010011" => data <= my_rom(211);
			WHEN "11010100" => data <= my_rom(212);
			WHEN "11010101" => data <= my_rom(213);
			WHEN "11010110" => data <= my_rom(214);
			WHEN "11010111" => data <= my_rom(215);
			WHEN "11011000" => data <= my_rom(216);
			WHEN "11011001" => data <= my_rom(217);
			WHEN "11011010" => data <= my_rom(218);
			WHEN "11011011" => data <= my_rom(219);
			WHEN "11011100" => data <= my_rom(220);
			WHEN "11011101" => data <= my_rom(221);
			WHEN "11011110" => data <= my_rom(222);
			WHEN "11011111" => data <= my_rom(223);
			WHEN "11100000" => data <= my_rom(224);
			WHEN "11100001" => data <= my_rom(225);
			WHEN "11100010" => data <= my_rom(226);
			WHEN "11100011" => data <= my_rom(227);
			WHEN "11100100" => data <= my_rom(228);
			WHEN "11100101" => data <= my_rom(229);
			WHEN "11100110" => data <= my_rom(230);
			WHEN "11100111" => data <= my_rom(231);
			WHEN "11101000" => data <= my_rom(232);
			WHEN "11101001" => data <= my_rom(233);
			WHEN "11101010" => data <= my_rom(234);
			WHEN "11101011" => data <= my_rom(235);
			WHEN "11101100" => data <= my_rom(236);
			WHEN "11101101" => data <= my_rom(237);
			WHEN "11101110" => data <= my_rom(238);
			WHEN "11101111" => data <= my_rom(239);
			WHEN "11110000" => data <= my_rom(240);
			WHEN "11110001" => data <= my_rom(241);
			WHEN "11110010" => data <= my_rom(242);
			WHEN "11110011" => data <= my_rom(243);
			WHEN "11110100" => data <= my_rom(244);
			WHEN "11110101" => data <= my_rom(245);
			WHEN "11110110" => data <= my_rom(246);
			WHEN "11110111" => data <= my_rom(247);
			WHEN "11111000" => data <= my_rom(248);
			WHEN "11111001" => data <= my_rom(249);
			WHEN "11111010" => data <= my_rom(250);
			WHEN "11111011" => data <= my_rom(251);
			WHEN "11111100" => data <= my_rom(252);
			WHEN "11111101" => data <= my_rom(253);
			WHEN "11111110" => data <= my_rom(254);
			WHEN "11111111" => data <= my_rom(255);
			WHEN OTHERS => data <= "ZZZZZZZZ";
		END CASE;
	END PROCESS;
	
END ARCHITECTURE;