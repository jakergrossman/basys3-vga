----------------------------------------------------------------------------------
-- Author: Jakery
-- 
-- Create Date: 06/30/2025 11:46:27 PM
-- Module Name: vga_top
-- Project Name: Basys 3 VGA Demo
-- Target Devices: Digilent Basys 3 (xc7a35tcpg236-1)
-- Description: Sample VHDL project exercising the VGA and QSPI peripherals on
--              the Digilent Basys 3 board for the AMD Artix 7 FPGA.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.numeric_std.all;

entity vga_top is
  port (
    signal i_sys_clk : in std_logic;
    signal i_center_button : in std_logic;
    signal o_vga_blanking : out std_logic;
    signal o_vga_r : out std_logic_vector(3 downto 0);
    signal o_vga_g : out std_logic_vector(3 downto 0);
    signal o_vga_b : out std_logic_vector(3 downto 0);
    signal o_vga_hsync : out std_logic;
    signal o_vga_vsync : out std_logic
  );
end vga_top;


architecture rtl of vga_top is
begin
  o_vga_blanking <= '1';
  o_vga_r <= "0101";
  o_vga_g <= "0101";
  o_vga_b <= "0101";
  o_vga_hsync <= '0';
  o_vga_vsync <= '0';
end rtl;
