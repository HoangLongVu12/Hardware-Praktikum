use work.ram;
use work.ram_pack.all;
	
entity write_tb is
end write_tb;

architecture structure of write_tb is 
component ram
	generic (adr_breite:	Integer:=4);
	port (	adr:			in BIT_VECTOR(0 to adr_breite-1); 
			din:			in BYTE_4;
			do: 			out BYTE_4;
			read_write: 	in BIT
			);
end component;
Signal adresse:		BIT_VECTOR(0 to 3);
signal din,do:		BYTE_4;				  
signal read_write:		BIT:='1';
begin
Testobject: ram
	port map(
		adr		=> adresse,
		din		=> din,
		do		=> do,
		read_write	=> read_write
	);
 
process 
 begin 
   adresse <= "0000" ;
   din <= "00000000000000000000000000000000" ;
   read_write <= '1'; 
  wait for 25 ns ;
  adresse <= "0001" ;
  din <= "00000000000000000000000000000001" ;
  read_write <= '0'; 
  wait for 25 ns ;
  adresse <= "0000" ;
  read_write <= '1'; 
  wait for 25 ns ;
  adresse <= "0011" ;
  read_write <='0';
  din <= "00000000000000000000000000000011" ;
  wait for 25 ns ;
  adresse <= "0001" ;
  read_write <='1';
  wait for 20 ns;
  read_write <= '0';
  wait for 100 ns ;
  read_write <= '1';
  adresse <= "0011";
  wait;
  end process ;
  end structure;