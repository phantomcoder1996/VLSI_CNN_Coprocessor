
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY AdderPart IS

PORT(   a0, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24 : in std_logic_vector(7 downto 0); --taken from dma
        b0, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24 : in std_logic_vector(7 downto 0); --taken from multiplication    
	s : out std_logic_vector(7 downto 0);
	ack :out std_logic;
        --,wr:out std_logic;
        en:in std_logic;
        conv,size:std_logic

-----conv =0  pooling=conv=1
-----size=0  when size =5,size=1 sizee=3

);
END AdderPart;
Architecture AdderPart of AdderPart is
Component my_adder is
	  port( a,b,cin : in std_logic; s,cout : out std_logic);
	end component;

SIGNAL c0, c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24 :  std_logic_vector(7 downto 0);  ---input
SIGNAL  d0, d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24 :  std_logic_vector(7 downto 0); --carry
SIGNAL  c25, c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c50 :  std_logic_vector(7 downto 0); 


signal q: unsigned(7 downto 0);---- for shifting 
signal d: unsigned(7 downto 0);

begin

q<=unsigned(c50) when en='1'
else "00000000";
d<="00000011" when en='1' and size='0'
else "00000101" when en='1' and size='1'
else "00000000";

c0<=a0 when conv='0' and en='1'
else b0 when conv='1' and en='1'
else "00000000";

c1<=a1 when conv='0' and en='1'
else b1 when conv='1' and en='1'
else "00000000";

c2<=a2 when conv='0' and en='1'
else b2 when conv='1' and en='1'
else "00000000";

c3<=a3 when conv='0' and en='1'
else b3 when conv='1' and en='1'
else "00000000";


c4<=a4 when conv='0' and en='1'
else b4 when conv='1' and en='1'
else "00000000";

c5<=a5 when conv='0' and en='1'
else b5 when conv='1' and en='1'
else "00000000";

c6<=a6 when conv='0' and en='1'
else b6 when conv='1' and en='1'
else "00000000";

c7<=a7 when conv='0' and en='1'
else b7 when conv='1' and en='1'
else "00000000";

c8<=a8 when conv='0' and en='1'
else b8 when conv='1' and en='1'
else "00000000";

c9<=a9 when conv='0' and en='1'
else b9 when conv='1' and en='1'
else "00000000";

c10<=a10 when conv='0' and en='1'
else b10 when conv='1' and en='1'
else "00000000";

c11<=a11 when conv='0' and en='1'
else b11 when conv='1' and en='1'
else "00000000";

c12<=a12 when conv='0' and en='1'
else b12 when conv='1' and en='1'
else "00000000";

c13<=a13 when conv='0' and en='1'
else b13 when conv='1' and en='1'
else "00000000";
c14<=a14 when conv='0' and en='1'
else b14 when conv='1' and en='1'
else "00000000";
c15<=a15 when conv='0' and en='1'
else b15 when conv='1' and en='1'
else "00000000";
c16<=a16 when conv='0' and en='1'
else b16 when conv='1' and en='1'
else "00000000";

c17<=a17 when conv='0' and en='1'
else b17 when conv='1' and en='1'
else "00000000";
c18<=a18 when conv='0' and en='1'
else b18 when conv='1' and en='1'
else "00000000";
c19<=a19 when conv='0' and en='1'
else b19 when conv='1' and en='1'
else "00000000";
c20<=a20 when conv='0' and en='1'
else b20 when conv='1' and en='1'
else "00000000";
c21<=a21 when conv='0' and en='1'
else b21 when conv='1' and en='1'
else "00000000";
c22<=a22 when conv='0' and en='1'
else b22 when conv='1' and en='1'
else "00000000";
c23<=a23 when conv='0' and en='1'
else b23 when conv='1' and en='1'
else "00000000";
c24<=a24 when conv='0' and en='1'
else b24 when conv='1' and en='1'
else "00000000";


add1 : my_adder port map(c0(0),c1(0),'0',c25(0),d0(0));
		loop1: for i in 1 to 7 generate
			fx: my_adder port map(c0(i),c1(i),d0(i-1),c25(i),d0(i));
		end generate;



add2 : my_adder port map(c2(0),c3(0),'0',c26(0),d1(0));
		loop2: for i in 1 to 7 generate
			fx: my_adder port map(c2(i),c3(i),d1(i-1),c26(i),d1(i));
		end generate;

add3 : my_adder port map(c5(0),c4(0),'0',c27(0),d2(0));
		loop3: for i in 1 to 7 generate
			fx: my_adder port map(c4(i),c5(i),d2(i-1),c27(i),d2(i));
		end generate;

add4 : my_adder port map(c6(0),c7(0),'0',c28(0),d3(0));
		loop4: for i in 1 to 7 generate
			fx: my_adder port map(c6(i),c7(i),d3(i-1),c28(i),d3(i));
		end generate;

add5 : my_adder port map(c9(0),c10(0),'0',c29(0),d4(0));
		loop5: for i in 1 to 7 generate
			fx: my_adder port map(c9(i),c10(i),d4(i-1),c29(i),d4(i));
		end generate;


add6 : my_adder port map(c11(0),c12(0),'0',c30(0),d5(0));
		loop6: for i in 1 to 7 generate
			fx: my_adder port map(c11(i),c12(i),d5(i-1),c30(i),d5(i));
		end generate;

add7 : my_adder port map(c13(0),c14(0),'0',c31(0),d6(0));
		loop7: for i in 1 to 7 generate
			fx: my_adder port map(c13(i),c14(i),d6(i-1),c31(i),d6(i));
		end generate;

add8 : my_adder port map(c15(0),c16(0),'0',c32(0),d7(0));
		loop8: for i in 1 to 7 generate
			fx: my_adder port map(c15(i),c16(i),d7(i-1),c32(i),d7(i));
		end generate;

add9 : my_adder port map(c17(0),c18(0),'0',c33(0),d8(0));
		loop9: for i in 1 to 7 generate
			fx: my_adder port map(c17(i),c18(i),d8(i-1),c33(i),d8(i));
		end generate;

add10 : my_adder port map(c19(0),c20(0),'0',c34(0),d9(0));
		loop10: for i in 1 to 7 generate
			fx: my_adder port map(c19(i),c20(i),d9(i-1),c34(i),d9(i));
		end generate;
add11 : my_adder port map(c21(0),c22(0),'0',c35(0),d10(0));
		loop11: for i in 1 to 7 generate
			fx: my_adder port map(c21(i),c22(i),d10(i-1),c35(i),d10(i));
		end generate;
add12 : my_adder port map(c23(0),c24(0),'0',c36(0),d11(0));
		loop12: for i in 1 to 7 generate
			fx: my_adder port map(c23(i),c24(i),d11(i-1),c36(i),d11(i));
		end generate;

add13 : my_adder port map(c25(0),c26(0),'0',c37(0),d12(0));
		loop13: for i in 1 to 7 generate
			fx: my_adder port map(c25(i),c26(i),d12(i-1),c37(i),d12(i));
		end generate;

add14 : my_adder port map(c27(0),c28(0),'0',c38(0),d13(0));
		loop14: for i in 1 to 7 generate
			fx: my_adder port map(c27(i),c28(i),d13(i-1),c38(i),d13(i));
		end generate;

add15 : my_adder port map(c29(0),c30(0),'0',c39(0),d14(0));
		loop15: for i in 1 to 7 generate
			fx: my_adder port map(c29(i),c30(i),d14(i-1),c39(i),d14(i));
		end generate;

add16 : my_adder port map(c31(0),c32(0),'0',c40(0),d15(0));
		loop16: for i in 1 to 7 generate
			fx: my_adder port map(c31(i),c32(i),d15(i-1),c40(i),d15(i));
		end generate;


add17 : my_adder port map(c33(0),c34(0),'0',c41(0),d16(0));
		loop17: for i in 1 to 7 generate
			fx: my_adder port map(c34(i),c34(i),d16(i-1),c41(i),d16(i));
		end generate;

add18 : my_adder port map(c35(0),c36(0),'0',c42(0),d17(0));
		loop18: for i in 1 to 7 generate
			fx: my_adder port map(c35(i),c36(i),d17(i-1),c42(i),d17(i));
		end generate;

add19 : my_adder port map(c37(0),c38(0),'0',c43(0),d18(0));
		loop19: for i in 1 to 7 generate
			fx: my_adder port map(c37(i),c38(i),d18(i-1),c43(i),d18(i));
		end generate;

add20 : my_adder port map(c39(0),c40(0),'0',c44(0),d19(0));
		loop20: for i in 1 to 7 generate
			fx: my_adder port map(c39(i),c40(i),d19(i-1),c44(i),d19(i));
		end generate;

add21 : my_adder port map(c41(0),c42(0),'0',c45(0),d20(0));
		loop21: for i in 1 to 7 generate
			fx: my_adder port map(c41(i),c42(i),d20(i-1),c45(i),d20(i));
		end generate;

add22 : my_adder port map(c43(0),c8(0),'0',c46(0),d21(0));
		loop22: for i in 1 to 7 generate
			fx: my_adder port map(c43(i),c8(i),d21(i-1),c46(i),d21(i));
		end generate;

add23 : my_adder port map(c44(0),c45(0),'0',c48(0),d22(0));
		loop23: for i in 1 to 7 generate
			fx: my_adder port map(c44(i),c45(i),d22(i-1),c48(i),d22(i));
		end generate;

add24 : my_adder port map(c46(0),c48(0),'0',c49(0),d23(0));
		loop24: for i in 1 to 7 generate
			fx: my_adder port map(c46(i),c48(i),d23(i-1),c49(i),d23(i));
		end generate;
c50<=c49 when size='1'and en='1'
else c46 when size='0' and en='1'
else "00000000";

s<=c50 when conv='0' and en='1'
else std_logic_vector(q srl to_integer(d))  when conv='1' and en='1'
else    "00000000";

ack<='1' when en='1'
else '0';
--wr<='1' when en='1'
--else '0';

end AdderPart;
