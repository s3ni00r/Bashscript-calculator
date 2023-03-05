#!/bin/bash
 
#This is a simple bash calculator
#Prerequisites
#You need to have whiptail and bc commands.
#Developed by (Mohamed Mekkawy – Abdelrahman Hassan – Ahmed Tariq – Abdallah Dagher – Ahmed Abdelsamad Elgabry).
 
 
inp=""
out=""
num=0
num2=0
out=""
 
#sin function
sin (){
input_func "Enter Number"
num=$inp
out=`echo "scale=5;s($num*0.017453293)" | bc -l`
normalsize_output_func $out
}
 
#cos function
cos (){
input_func "Enter Number"
num=$inp
out=`echo "scale=5;c($num*0.017453293)" | bc -l`
normalsize_output_func $out
}
#tan function
tan (){
input_func "Enter Number"
num=$inp
out=`echo "scale=5;s($num*0.017453293)/c($num*0.017453293)" | bc -l`
normalsize_output_func $out
}
 
#mod function
mod (){
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number" "Mod"
local inret=$?
num2=$inp
if [[ $inret -eq 10 ]]
then
normalsize_output_func "Undefined"
else
out=`echo "$num%$num2" | bc`
normalsize_output_func $out
fi
}
 
#sum function
sum (){
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number"
num2=$inp
out=`echo "scale=5; $num+$num2" | bc`
normalsize_output_func $out
}
 
#sub function
sub (){
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number"
num2=$inp
out=`echo "scale=5; $num-$num2" | bc`
normalsize_output_func $out
}
 
#multiplication function
prod (){
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number"
num2=$inp
out=`echo "scale=5; $num*$num2" | bc`
normalsize_output_func $out
}
 
#division function
div (){
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number" "Enter Second Number"
num2=$inp
out=`echo "scale=5; $num/$num2" | bc`
normalsize_output_func $out
}
 
#base conversion function for (decimal,binary,octal,hexadecimal)
number_conversion (){
base_name=("Decimal" "Binary" "Octal"  "Hexdecimal")
base_num=("10" "2" "8" "16")
 
input_func "Enter ${base_name[$1]} Number" "${base_num[$1]}"
num=$inp
for b in ${!base_num[@]}
do
out+="\n${base_name[$b]}:\n"
out+=`echo "obase=${base_num[$b]};ibase=${base_num[$1]};$num" | bc`
done
extendedsize_output_func $out
}
 
#sift right
shift_right (){
input_func "Enter Number to Shift"
num=$inp
input_func "Enter Shift Prefix"
num2=$inp
out=$(($num/2**$num2))
normalsize_output_func $out
}
 
#shift left
shift_left (){
input_func "Enter Number to Shift"
num=$inp
input_func "Enter Shift Prefix"
num2=$inp
out=$(($num*2**$num2))
normalsize_output_func $out
}
 
#or gate
or_gate (){
 
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number"
num2=$inp
out=$(($num|$num2))
normalsize_output_func $out
}
 
#and gate
and_gate (){
 
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number"
num2=$inp
out=$(($num&$num2))
normalsize_output_func $out
}
 
#xor gate
xor_gate (){
 
input_func "Enter First Number"
num=$inp
input_func "Enter Second Number"
num2=$inp
out=$(($num^$num2))
normalsize_output_func $out
}
 
#standard menu
standard () {
stan=$(whiptail --title "Standard" --notags  --cancel-button Back --menu "Choose an option" 20 78 10 \
"0" "Addition" \
"1" "Subtraction" \
"2" "Multiplication" \
"3" "Division"  3>&1 1>&2 2>&3)
 
if [ $? -ne 0 ]
then
return 10
fi
 
case $stan in
"0")
sum
;;
"1")
sub
;;
"2")
prod
;;
"3")
div
;;
esac
 
}
 
#scientific menu
scientific (){
sci=$(whiptail --title "Scientific" --notags  --cancel-button Back --menu "Choose an option" 20 78 10 \
"0" "Modulus" \
"1" "Sin" \
"2" "Cos" \
"3" "Tan"  3>&1 1>&2 2>&3)
 
if [ $? -ne 0 ]
then
return 10
fi
 
case $sci in
"0")
mod
;;
"1")
sin
;;
"2")
cos
;;
"3")
tan
;;
esac
}
 
#programmer menu
programmer (){
prog=$(whiptail --title "Programmer" --notags  --cancel-button Back --menu "Choose an option" 20 78 10 \
"0" "Decimal" \
"1" "Binary" \
"2" "Octal" \
"3" "Hex" \
"4" "Shift Right" \
"5" "Shift Left" \
"6" "OR" \
"7" "AND" \
"8" "XOR" 3>&1 1>&2 2>&3)
 
if [ $? -ne 0 ]
then
return 10
fi
 
case $prog in
"0")
number_conversion 0
;;
"1")
number_conversion 1
;;
"2")
number_conversion 2
;;
"3")
number_conversion 3
;;
"4")
shift_right
;;
"5")
shift_left
;;
"6")
or_gate
;;
"7")
and_gate
;;
"8")
xor_gate
;;
esac
}
 
#input_func handling function
input_func (){
while true
do
inp=$(whiptail --inputbox --nocancel "$1" 8 39 --title "Number Input"  3>&1 1>&2 2>&3)
exitstatus=$?
if [[ $inp == "" ]]
then
err=$(whiptail --title "Error" --msgbox "Value can't be empty." 8 78 3>&1 1>&2 2>&3)
elif [[ $2 = "10" && $inp =~ [^0-9] ]] || [[ $2 != "16"  &&  $2 != "2"  && !  $inp =~ ^[-]?[0-9]+\.?[0-9]*$ ]]
then
err=$(whiptail --title "Error" --msgbox "You have to provide valid number." 8 78 3>&1 1>&2 2>&3)
elif [[ $2 = "2"  &&  $inp =~ [^0-1] ]]
then
err=$(whiptail --title "Error" --msgbox "You have to provide 0 or 1." 8 78 3>&1 1>&2 2>&3)
elif [[ $2 = "16"  &&  $inp =~ [^0-9A-F] ]]
then
err=$(whiptail --title "Error" --msgbox "Hex charaters are: A-B-C-D-E-F." 8 78 3>&1 1>&2 2>&3)
elif [[ "$1" = "$2"  &&  $inp -eq 0 ]]
then
err=$(whiptail --title "Error" --msgbox "You can't divide by zero." 8 78 3>&1 1>&2 2>&3)
elif [[ $2 = "Mod"  &&  $inp -eq 0 ]]
then
return 10
else
return
fi
done
 
}
 
#output_func handling function
output_func (){
out=$(whiptail --title "Result" --msgbox  "The result is: $1" $2 $3 3>&1 1>&2 2>&3)
}
 
normalsize_output_func (){
output_func $1 10 78
}
 
extendedsize_output_func (){
output_func $1 20 78
}
 
whiptail_error (){
exit
echo "f"
}
 
#calculator main menu
main_menu (){
menu=$(whiptail --title "Calculator" --menu --notags --cancel-button Back "Choose an option" 20 78 10 \
"0" "Standard" \
"1" "Scientific" \
"2" "Progammer" 3>&1 1>&2 2>&3)
 
case $menu in
"0")
while true
do
standard
if [ $? -eq 10 ]
then
break
fi
done
;;
"1")
while true
do
scientific
if [ $? -eq 10 ]
then
break
fi
done
;;
"2")
while true
do
programmer
if [ $? -eq 10 ]
then
break
fi
done
;;
*)
return 10
;;
esac
}
 
#documentation page
doc_page (){
text="Calculator using Terminal User Interface\n\n•   this is our bash scripting project (Calculator using TUI)\n\n•  The Calculator has Three Modes:-\n\no   Standard Mode\no   Scientific Mode \no   Programmer Mode\n\n\n1. Standard Mode \n\n   The most basic Mode is the (four-function calculator), which can perform basic arithmetic such as addition, subtraction, multiplication and division.\n\n•   Four-function calculators usually have a ( +, -, x and / ) sign to denote the operations and can produce numbers. \n\n2. Scientific Mode \n\n•   As its name suggests, the scientific calculator is designed for performing scientific calculations.\n\n•   This type of calculator usually has more buttons (Functions) than a standard calculator, as it needs to be able to perform trigonometric functions, logarithms, sine/cosine and exponential operations.\n\n•   The main Functions of Scientific Mode is { sine Function, Cosine Function, The tangent function (Tan) and The MOD Function}\n\n\n\n3. Programmer Mode\n\n•   Programmer Mode are the mode that can automatically carry out a sequence of operations under control of a stored program. \n\n•   Programmer mode has (Three Main Operations)\n\n•   Bit Shift Operations\n•   Bitwise Operations\n•   Base Converter Operations\n\nA.   ( Bit Shift Operations )\n\n•   A bit-shift moves each digit in a number’s binary representation left or right. Within right-shifts. \n•   there are two further divisions: ( logical right-shift and arithmetic right-shift. \n\n•   A left-shift is represented by the << operator, while a right-shift is represented by the >> operator.\n\nB.   Bitwise Operations\n\n•   A bitwise operation is executed on a binary number, which can also be seen as a string of bits.\n\n•   The bitwise calculator can perform 6 different bitwise operations: ( bitwise AND, bitwise OR, bitwise XOR, bitwise Not, bitwise NAND, bitwise NOR) \n\no   Bitwise AND: The corresponding bit of the result is 1 if both input_func numbers have a 1 on this bit; otherwise, it is 0.\no   Bitwise OR: The corresponding bit of the result is 1 if at least one input_func number has a 1 on this bit; otherwise, it is 0.\no   Bitwise XOR/exclusive OR: The corresponding bit of the result is 1 if one and only one input number has a 1 on this bit; otherwise it's 0. \n\nC.   BASE Converter Operations \n•   Convert between Decimal (base 10) and BINARRY (BASE 2)\n•   Convert between Decimal (base 10) and Octal (BASE 8)\n•   Convert between Decimal (base 10) and Hexadecimal (BASE 16) \n\n\nThis Project is Developed by\n(Mohamed Mekkawy – Abdelrahman Hassan – Ahmed Tariq – Abdallah Dagher – Ahmed Abdelsamad Elgabry)\n\nSupervised by \n(Eng kariem Abdelhamid)\n\n3/1/2023\nITI CYBER SECURITY TRACK INTAKE 43\n"
doc=$(whiptail --title "Documentation" --msgbox "$text" --scrolltext 25 78 3>&1 1>&2 2>&3)
}
 
#developers page
developers_page (){
text="• Mohamed Mekkawy\n• Abdelrahman Hassan\n• Ahmed Tariq\n• Abdallah Dagher\n• Ahmed Abdelsamad Elgabry"
devs=$(whiptail --title "Developers" --msgbox "$text" 20 78 3>&1 1>&2 2>&3)
}
 
welcome_message (){
whiptail --title "Welcome message " --msgbox " Hello, Welcome to our calculator :)" 8 78  3>&1 1>&2 2>&3
}
 
#welcome menu
welcome_menu (){
menu=$(whiptail --title "Calculator" --menu --notags --cancel-button Quit "Choose an option" 20 78 10 \
"0" "Calculator" \
"1" "Documentation" \
"2" "Developers" 3>&1 1>&2 2>&3)
case $menu in
"0")
while true
do
main_menu
if [ $? -eq 10 ]
then
break
fi
done
;;
"1")
doc_page
;;
"2")
developers_page
;;
*)
exit
;;
esac
}
 
 
 
welcome_message
 
while true
do
welcome_menu
done
