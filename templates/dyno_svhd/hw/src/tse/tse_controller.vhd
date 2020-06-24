-- Example VHDL Template - vhdl_design_template.vhd --
--**************************************************************************--
-- FILE TAB STOP ALIGNMENT is SET AT 4 SPACES... PLEASE MAINTAIN --
--**************************************************************************--
-- --
-- DESIGNED BY: Alex Aleyan
-- - - - - - - - NetQuest Corporation - - - - - - - --
-- - - - - - - - 523 Fellowship Road, Suite 205 - - - - - - - --
-- - - - - - - - Mt. Laurel, NJ 08054 - - - - - - - --
-- - - - - - - - (856) 866-0505 - - - - - - - --
--
--
-- PROJECT: Design and Test Bench Template
--
-- MODULE: vhdl_design_template.vhd 
-- 
-- PURPOSE: Example VHDL Template 
-- 
-- DATE: 06/23/2020 
-- 
-- ENGINEER: Alex Aleyan
-- 
--**************************************************************************
-- Copyright 20** by NetQuest Corporation 
-- 
-- All rights reserved. No part of this program may be 
-- reproduced, stored in a retrieval system, or transmitted 
-- in any form or by any means, electronic, mechanical, 
-- photocopying, recording, or otherwise, without the written 
-- permission of NetQuest Inc. 
--**************************************************************************
--
-- REVISION HISTORY 
--
-- $Id: $
--
-- $Revision: $
--
-- $Author: $
--
-- $Log: $
--
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;
use ieee.math_real.all; --"ceil";

-- library altera;
-- use altera.altera_syn_attributes.all;
-- library work;
use work.avalon_interface_vhdl_pkg.all;
-- generic map (ST_DATA_WIDTH => 32);



entity tse_controller is
  generic( 
    SPEED_SENSOR_WIDTH        : positive := 16;
    ADC_WIDTH                 : positive := 16;
    TSE_TX_ST_DATA_WIDTH      : positive := 32;
    TSE_CONTROL_MM_DATA_WIDTH : positive := 32;
    
    FSM_COUNTER_SPAN          : positive := 250000000;
    FSM_WAIT_TO_INIT          : positive := 5;
    FSM_WAIT_SEND_AGAIN       : positive := 5;
                              
    LINK_LAYER_BYTES          : positive := 16;
    IP_LAYER_BYTES            : positive := 20;
    UDP_LAYER_BYTES           : positive := 8;
    DATA_LAYER_BYTES          : positive := 24
    -- ;
    -- package p1 is new work.interface_design_pkg
    --     generic map (ST_DATA_WIDTH => 32)

  );
  port( 
    -- Inputs:
    CLOCK       : in    std_logic;
    RESET_N     : in    std_logic;
    SEND_PACKET : in    std_logic;
    
    -- User Interface:
    MTU                 : in    std_logic_vector(15 downto 0);
    SPEED_SENSOR        : in    std_logic_vector(SPEED_SENSOR_WIDTH-1 downto 0);
    ADC                 : in    std_logic_vector(ADC_WIDTH-1 downto 0);

    -- Avalon-ST Master:  
    AVALON_ST_SOURCE_IN_1    : in    to_AvalonST_source;
	AVALON_ST_SOURCE_OUT_1   : out   from_AvalonST_source;
    
    -- Avalon-MM Master:
    AVALON_MM_MASTER_IN_1    : in    to_AvalonMM_Master;
	AVALON_MM_MASTER_OUT_1   : out   from_AvalonMM_Master
    
    );
end tse_controller ;


architecture fsm of tse_controller is


-- LINK HEADER:
-- 0x00,0x00,0x01,0x00, // 0      0      MAC     MAC
-- 0x5e,0x01,0x01,0x01, // MAC    MAC    MAC     MAC
-- 0x54,0x53,0xed,0xb5, // MAC    MAC    MAC     MAC
-- 0x2d,0xaa,0x08,0x00, // MAC    MAC    type    type

-- IP HEADER:
-- 0x45,0x00,0x00,0x22, // VERIHL TOSECN LENGTH  LENGTH
-- 0xb9,0xa3,0x40,0x00, // ID     ID     FLAG----OFFSET
-- 0x01,0x11,0x05,0x7b, // TTL    Proto  Header--ChkSum
-- 0xc0,0xa8,0x0a,0x02, // source----IP----------address
-- 0xef,0x01,0x01,0x01, // destination---IP------address

-- UDP HEADER:
-- 0xbe,0x98,0x23,0x82, // Source-Port   DestinationPort
-- 0x00,0x0e,0x3e,0xe3, // length-length CheckSumChecksum



                                                                         
signal Start_xS, Tx_Sop_xS  : std_logic ;
signal Stop_xS              : std_logic ;

signal Tx_Data_xD           : std_logic_vector(TSE_TX_ST_DATA_WIDTH-1 downto 0);
signal Speed_Sensor_xD : std_logic_vector(SPEED_SENSOR_WIDTH-1 downto 0);
signal Adc_xD          : std_logic_vector(ADC_WIDTH-1 downto 0);       

signal Counter_xD   : std_logic_vector(integer(ceil(log2(real(FSM_COUNTER_SPAN))))-1 downto 0);
signal Reset_n_xS   : std_logic ;

  
type STATE_TYPE is (RESET,
                    INITIALIZE_TSE_VIA_MM,
                    RESEND_INIT_ON_WAITREQUEST1,
                    WAIT_DELAY1, 
                    ENABLE_TSE_VIA_MM, 
                    RESEND_ON_WAITREQUEST2, 
                    IDLE, 
                    SEND_LINK_HEADER, 
                    SEND_IP_HEADER, 
                    SEND_UDP_HEADER, 
                    SEND_PAYLOAD, 
                    WAIT_DELAY);                    

attribute syn_encoding : string;
attribute syn_encoding of STATE_TYPE : type is "safe, onehot";

signal next_state : STATE_TYPE;

-- // Initialize the MAC address 
-- *(tse + 3) = 0xb5ed5354;
-- *(tse + 4) = 0x0000aa2d; 

-- // Specify the addresses of the PHY devices to be accessed through MDIO interface
-- *(tse + 0x0F) = 0x10;
-- *(tse + 0x10) = 0x11;

-- //PHY0:
-- // Write to register 20 of the PHY chip for Ethernet port 0 to set up line loopback
-- *(tse + 0x94) = 0x4000;

-- //PHY1:
-- // Write to register 16 of the PHY chip for Ethernet port 1 to enable automatic crossover for all modes
-- *(tse + 0xB0) = *(tse + 0xB0) | 0x0060;	
-- // Write to register 20 of the PHY chip for Ethernet port 1 to set up delay for input/output clk
-- *(tse + 0xB4) = *(tse + 0xB4) | 0x0082;
-- // Software reset the second PHY chip and wait
-- *(tse + 0xA0) = *(tse + 0xA0) | 0x8000;
-- while ( *(tse + 0xA0) & 0x8000  );	 
 
-- //TSE Megafunction:
-- // Enable read and write transfers, gigabit Ethernet operation, and CRC forwarding
-- //*(tse + 2) = *(tse + 2) | 0x0000004B;
-- *(tse + 2) = *(tse + 2) | 0x00000043;
type Mem_40byN is array (0 to 7) of std_logic_vector(39 downto 0);
constant Tse_Control_Reg_xD : Mem_40byN := (x"03_b5ed5354", 
                                            x"04_0000aa2d", 
                                            x"0F_00000010", 
                                            x"10_00000011", 
                                            x"94_00004000", 
                                            x"B0_00000078", 
                                            x"B4_00000ce2",
                                            x"A0_00009140");
         
constant TSE_ENABLE_TX_RX : std_logic_vector(39 downto 0) := x"02_00000043";   

-- LINK HEADER:
-- byte0|byte1|byte2|byte3:
-- 0x00  0x00  0x01  0x00  // 0      0      MAC     MAC
-- 0x5e  0x01  0x01  0x01  // MAC    MAC    MAC     MAC
-- 0x54  0x53  0xed  0xb5  // MAC    MAC    MAC     MAC
-- 0x2d  0xaa  0x08  0x00  // MAC    MAC    type    type
constant LINK_HEADER : std_logic_vector(((LINK_LAYER_BYTES*8)-1) downto 0) := x"00_08_aa_2d" & 
                                                                              x"b5_ed_53_54" & 
                                                                              x"01_01_01_5e" & 
                                                                              x"00_01_00_00";

-- IP Header, IP Header Total Length (bytes in IP Header and Data Layer),and Checksum:
signal IP_HEADER      : std_logic_vector(((IP_LAYER_BYTES*8)  -1) downto 0);
signal Ip_Total_Len   : std_logic_vector(15 downto 0);
signal chksum_01_xD : std_logic_vector(16 downto 0);
signal chksum_02_xD : std_logic_vector(16 downto 0);
signal chksum_03_xD : std_logic_vector(16 downto 0);
signal chksum_04_xD : std_logic_vector(16 downto 0);
signal chksum_11_xD : std_logic_vector(17 downto 0);
signal chksum_12_xD : std_logic_vector(17 downto 0);
signal chksum_21_xD : std_logic_vector(18 downto 0);
signal chksum_31_xD : std_logic_vector(19 downto 0);
signal chksum_41_xD : std_logic_vector(20 downto 0);
signal chksum_51_xD : std_logic_vector(16 downto 0);
signal chksum_xD : std_logic_vector(15 downto 0);


signal UDP_HEADER    : std_logic_vector(((UDP_LAYER_BYTES*8) -1) downto 0);
signal Udp_Total_Len : std_logic_vector(15 downto 0);




-- IP HEADER:
-- 0x45,0x00,0x00,0x22, // VERIHL TOSECN LENGTH  LENGTH
-- 0xb9,0xa3,0x40,0x00, // ID     ID     FLAG----OFFSET
-- 0x01,0x11,0x05,0x7b, // TTL    Proto  Header--ChkSum
-- 0xc0,0xa8,0x0a,0x02, // source----IP----------address
-- 0xef,0x01,0x01,0x01, // destination---IP------address
constant ip_hdr1 : std_logic_vector(15 downto 0) := x"4500";
constant ip_hdr2 : std_logic_vector(15 downto 0) := x"b9a3";
constant ip_hdr3 : std_logic_vector(15 downto 0) := x"4000";
constant ip_hdr4 : std_logic_vector(15 downto 0) := x"0111";
constant ip_hdr5 : std_logic_vector(15 downto 0) := x"c0a8";
constant ip_hdr6 : std_logic_vector(15 downto 0) := x"0a02";
constant ip_hdr7 : std_logic_vector(15 downto 0) := x"ef01";
constant ip_hdr8 : std_logic_vector(15 downto 0) := x"0101";


begin

 
-- Registered Inputs:
registered_inputs : process (CLOCK)
begin
if (CLOCK'event and CLOCK = '1') then
  Start_xS          <= SEND_PACKET;
  Reset_n_xS        <= RESET_N;
  Speed_Sensor_xD   <= SPEED_SENSOR;
  Adc_xD            <= ADC;
end if;
end process registered_inputs;


-- IP HEADER:
-- 0x45,0x00,0x00,0x22, // VERIHL TOSECN LENGTH  LENGTH
-- 0xb9,0xa3,0x40,0x00, // ID     ID     FLAG----OFFSET
-- 0x01,0x11,0x05,0x7b, // TTL    Proto  Header--ChkSum
-- 0xc0,0xa8,0x0a,0x02, // source----IP----------address
-- 0xef,0x01,0x01,0x01, // destination---IP------address
ip_header_proc : process (CLOCK)
begin
  if (CLOCK'event and CLOCK = '1') then
  
    Ip_Total_Len <= std_logic_vector(to_unsigned(IP_LAYER_BYTES + UDP_LAYER_BYTES + to_integer(unsigned(MTU)),16));
    
    --Calculate header checksum:
    -- 1st stage pipeline:
    chksum_01_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(Ip_Total_Len)) + to_integer(unsigned(ip_hdr1)),17));
    chksum_02_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(ip_hdr3)) + to_integer(unsigned(ip_hdr2)),17));
    chksum_03_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(ip_hdr5)) + to_integer(unsigned(ip_hdr4)),17));
    chksum_04_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(ip_hdr7)) + to_integer(unsigned(ip_hdr6)),17));
    -- 2nd stage pipeline:
    chksum_11_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(chksum_01_xD)) + to_integer(unsigned(chksum_02_xD)),18));
    chksum_12_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(chksum_03_xD)) + to_integer(unsigned(chksum_04_xD)),18));
    -- 3rd stage pipeline:
    chksum_21_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(chksum_11_xD)) + to_integer(unsigned(chksum_12_xD)),19));
    -- 4th stage pipeline:
    chksum_31_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(ip_hdr8)) + to_integer(unsigned(chksum_21_xD)),20));
    -- 5th stage pipeline:
    chksum_41_xD <= std_logic_vector(to_unsigned(to_integer(unsigned(chksum_31_xD(19 downto 16))) + to_integer(unsigned(chksum_31_xD(15 downto 0))), 21));
    -- 6th stage pipeline:
    chksum_xD <= not (std_logic_vector(to_unsigned(to_integer(unsigned(chksum_41_xD(20 downto 16))) + to_integer(unsigned(chksum_41_xD(15 downto 0))), 16)));
    
    IP_HEADER <= x"01_01_01_ef" & 
                 x"02_0a_a8_c0" & 
                 chksum_xD(7 downto 0) & 
				 chksum_xD(15 downto 8) & 
				 x"11_01" &               
                 x"00_40_a3_b9" & 
                 Ip_Total_Len(7 downto 0) & 
				 Ip_Total_Len(15 downto 8) & 
				 x"00_45";
                 
  end if;
end process ip_header_proc;

 
-- UDP HEADER:
-- 0xbe,0x98,0x23,0x82, // Source-Port   DestinationPort
-- 0x00,0x0e,0x3e,0xe3, // length-length CheckSumChecksum
-- Registered Inputs:
udp_header_proc : process (CLOCK)
begin
  if (CLOCK'event and CLOCK = '1') then
    Udp_Total_Len <= std_logic_vector(to_unsigned(UDP_LAYER_BYTES + to_integer(unsigned(MTU)),16));
    UDP_HEADER  <= x"00_00" & 
	               Udp_Total_Len(7 downto 0) & 
				   Udp_Total_Len(15 downto 8) &
                   x"82_23_98_be";
  end if;
end process udp_header_proc;


-- Byte swap the endianess on the data sent to TSE Module since we implement little endianess while altera uses big endian:
byte_swap: for k in 0 to (TSE_TX_ST_DATA_WIDTH/8-1) generate
  AVALON_ST_SOURCE_OUT_1.Data(((k*8)+8)-1 downto ((k*8))) <= Tx_Data_xD( (32-((k*8))-1) downto (32-((k*8)+8)));
end generate byte_swap; 


---------------------------------------------------------------------
-- 1. Add State Machine.
-- 2. use case statement to implement next logic:
--   when state is SEND LINK HEADER, MUX the LINK_HEADER to Tx_data
--   when state is SEND IP HEADER, MUX the IP_HEADER to Tx_data
--   when state is SEND UDP HEADER, MUX the UDP_HEADER to Tx_data
--   when state is SEND DATA, MUX the DATA to Tx_data
nextstate_proc : process (CLOCK)
begin
if (CLOCK'event and CLOCK = '1') then
  -- Default Assignments:
  Counter_xD  <= (others => '0');
  next_state <= RESET;
  
  AVALON_ST_SOURCE_OUT_1.Error <= (others => '0');
  AVALON_ST_SOURCE_OUT_1.Valid <= '0';
  AVALON_ST_SOURCE_OUT_1.Sop   <= '0'; 
  AVALON_ST_SOURCE_OUT_1.Eop   <= '0';
  AVALON_ST_SOURCE_OUT_1.Empty <= '0';
  Tx_Data_xD  <= (others => '0');
  
  AVALON_MM_MASTER_OUT_1.Address     <= (others => '0');
  AVALON_MM_MASTER_OUT_1.Read        <= '0';
  AVALON_MM_MASTER_OUT_1.WriteData   <= (others => '0');
  AVALON_MM_MASTER_OUT_1.Write       <= '0';
 
  if (Reset_n_xS = '0') then
    next_state <= RESET;
  else
    case next_state is
    when RESET => 
      next_state  <= INITIALIZE_TSE_VIA_MM;
      Counter_xD     <= std_logic_vector(unsigned( Counter_xD) + 1);
      if (unsigned(Counter_xD) < (FSM_WAIT_TO_INIT)) then
        next_state <= RESET;
      else
        next_state <= INITIALIZE_TSE_VIA_MM;
        Counter_xD  <= (others => '0');
      end if; 
    when INITIALIZE_TSE_VIA_MM => -- 
	  Counter_xD <= Counter_xD;
      AVALON_MM_MASTER_OUT_1.Write      <= '1';
      AVALON_MM_MASTER_OUT_1.Address    <= Tse_Control_Reg_xD(to_integer(unsigned(Counter_xD))) (39 downto TSE_CONTROL_MM_DATA_WIDTH);
      AVALON_MM_MASTER_OUT_1.WriteData  <= Tse_Control_Reg_xD(to_integer(unsigned(Counter_xD))) (TSE_CONTROL_MM_DATA_WIDTH -1 downto 0);
	  next_state <= RESEND_INIT_ON_WAITREQUEST1;
	
	when RESEND_INIT_ON_WAITREQUEST1 =>
      Counter_xD   <= std_logic_vector(unsigned( Counter_xD) + 1);
	  AVALON_MM_MASTER_OUT_1.Write      <= '1';
	  AVALON_MM_MASTER_OUT_1.Address    <= Tse_Control_Reg_xD(to_integer(unsigned(Counter_xD))) (39 downto TSE_CONTROL_MM_DATA_WIDTH);
      AVALON_MM_MASTER_OUT_1.WriteData  <= Tse_Control_Reg_xD(to_integer(unsigned(Counter_xD))) (TSE_CONTROL_MM_DATA_WIDTH -1 downto 0);
      if ( AVALON_MM_MASTER_IN_1.WaitRequest = '1') then
        Counter_xD <= Counter_xD;
		next_state <= RESEND_INIT_ON_WAITREQUEST1;
      else
        AVALON_MM_MASTER_OUT_1.Write      <= '0';
	    if (unsigned(Counter_xD) < (Tse_Control_Reg_xD'LENGTH - 1) ) then
          next_state <= INITIALIZE_TSE_VIA_MM;
        else
          next_state <= WAIT_DELAY1;
          Counter_xD  <= (others => '0');
        end if;
      end if;
  
    when WAIT_DELAY1 => -- replace with read for soft reset to finish :)
      Counter_xD     <= std_logic_vector(unsigned( Counter_xD) + 1);
      if (unsigned(Counter_xD) < (5)) then
        next_state <= WAIT_DELAY1;
      else
        next_state <= ENABLE_TSE_VIA_MM;
        Counter_xD  <= (others => '0');
      end if;
     
    when ENABLE_TSE_VIA_MM =>
      AVALON_MM_MASTER_OUT_1.Write      <= '1';
      AVALON_MM_MASTER_OUT_1.Address    <= TSE_ENABLE_TX_RX(39 downto TSE_CONTROL_MM_DATA_WIDTH);
      AVALON_MM_MASTER_OUT_1.WriteData  <= TSE_ENABLE_TX_RX(TSE_CONTROL_MM_DATA_WIDTH -1 downto 0);
	  next_state <= RESEND_ON_WAITREQUEST2;
 
	when RESEND_ON_WAITREQUEST2 =>
	  AVALON_MM_MASTER_OUT_1.Write      <= '1';
      AVALON_MM_MASTER_OUT_1.Address    <= TSE_ENABLE_TX_RX(39 downto TSE_CONTROL_MM_DATA_WIDTH);
      AVALON_MM_MASTER_OUT_1.WriteData  <= TSE_ENABLE_TX_RX(TSE_CONTROL_MM_DATA_WIDTH -1 downto 0);
      if ( AVALON_MM_MASTER_IN_1.WaitRequest = '1') then
        next_state <= RESEND_ON_WAITREQUEST2;
      else
	    AVALON_MM_MASTER_OUT_1.Write      <= '0';
        next_state <= IDLE;
      end if;
	
    when IDLE =>
      if ( Start_xS = '1' ) then
        next_state <= SEND_LINK_HEADER;
      else
        next_state <= IDLE;
      end if;
	 
    when SEND_LINK_HEADER =>
      Counter_xD   <= std_logic_vector(unsigned( Counter_xD) + 1);
      AVALON_ST_SOURCE_OUT_1.Sop   <= '1';
      AVALON_ST_SOURCE_OUT_1.Valid <= '1';
      Tx_Data_xD  <= LINK_HEADER( ((to_integer(unsigned(Counter_xD))*TSE_TX_ST_DATA_WIDTH)+TSE_TX_ST_DATA_WIDTH)-1 downto ((to_integer(unsigned(Counter_xD))*TSE_TX_ST_DATA_WIDTH)));
      if ( AVALON_ST_SOURCE_IN_1.Ready = '0') then
        Counter_xD <= Counter_xD;
      end if;
      if (unsigned(Counter_xD) > 0 ) then
        AVALON_ST_SOURCE_OUT_1.Sop <= '0';
      end if;
      if (unsigned(Counter_xD) < ((LINK_LAYER_BYTES/4)-1)) then
        next_state <= SEND_LINK_HEADER;
      else
        next_state <= SEND_IP_HEADER;
        Counter_xD  <= (others => '0');
      end if;

    when SEND_IP_HEADER =>
      AVALON_ST_SOURCE_OUT_1.Valid <= '1';
      Tx_Data_xD  <= IP_HEADER( ((to_integer(unsigned(Counter_xD))*TSE_TX_ST_DATA_WIDTH)+TSE_TX_ST_DATA_WIDTH)-1 downto ((to_integer(unsigned(Counter_xD))*TSE_TX_ST_DATA_WIDTH)));
      Counter_xD     <= std_logic_vector(unsigned( Counter_xD) + 1);
      if ( AVALON_ST_SOURCE_IN_1.Ready = '0') then
        Counter_xD <= Counter_xD;
      end if;
      if (unsigned(Counter_xD) < ((IP_LAYER_BYTES/4)-1)) then
        next_state <= SEND_IP_HEADER;
      else
        next_state <= SEND_UDP_HEADER;
        Counter_xD  <= (others => '0');
      end if;

    when SEND_UDP_HEADER =>
      AVALON_ST_SOURCE_OUT_1.Valid <= '1';
      Tx_Data_xD  <= UDP_HEADER( ((to_integer(unsigned(Counter_xD))*TSE_TX_ST_DATA_WIDTH)+TSE_TX_ST_DATA_WIDTH)-1 downto ((to_integer(unsigned(Counter_xD))*TSE_TX_ST_DATA_WIDTH)));
      Counter_xD     <= std_logic_vector(unsigned( Counter_xD) + 1);
      if ( AVALON_ST_SOURCE_IN_1.Ready = '0') then
        Counter_xD <= Counter_xD;
      end if;
      if (unsigned(Counter_xD) < ((UDP_LAYER_BYTES/4)-1)) then
        next_state <= SEND_UDP_HEADER;
      else
        next_state <= SEND_PAYLOAD;
        Counter_xD  <= (others => '0');
      end if; 
       
    when SEND_PAYLOAD =>
      AVALON_ST_SOURCE_OUT_1.Valid <= '1';
      Counter_xD  <= std_logic_vector(unsigned( Counter_xD) + 1);
      Tx_Data_xD  <= Speed_Sensor_xD & Adc_xD;
      if ( AVALON_ST_SOURCE_IN_1.Ready = '0') then
        Counter_xD <= Counter_xD;
      end if;
      if (unsigned(Counter_xD) = ((to_integer(unsigned(MTU))/4)-1)) then
        AVALON_ST_SOURCE_OUT_1.Eop <= '1';
      end if;
      if (unsigned(Counter_xD) < ((to_integer(unsigned(MTU))/4)-1)) then
        next_state <= SEND_PAYLOAD;
      else
        next_state <= WAIT_DELAY;
        Counter_xD  <= (others => '0');
      end if;
       
    when WAIT_DELAY =>
      Counter_xD     <= std_logic_vector(unsigned( Counter_xD) + 1);
      if (unsigned(Counter_xD) < (FSM_WAIT_SEND_AGAIN)) then
        next_state <= WAIT_DELAY;
      else
        next_state <= IDLE;
        Counter_xD  <= (others => '0');
      end if;
       
    when others =>
    end case;
  end if;
end if;
end process nextstate_proc; 

  
end fsm;
