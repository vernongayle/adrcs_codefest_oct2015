STOP
********************************************************************************
********************************************************************************
****CODEFEST
********************************************************************************
*Codefest is awesome!!


* Change working directory

pwd
cd F:\rft-teaching-file\
pwd
import delimited "2011 Census Microdata Teaching File.csv", varnames(2)  clear

********************************************************************************
*09/10/2015
*Playford, Connelly, Cullis
*Codefest Activity
*We want to make a table in Playford's desired format. 

********************************************************************************

*Using example synthetic census data

*Tab everything by a binary variable Sex

*Prepare the variable labels for sex, marital status, student status and health
numlabel, add

label define sexl 1 "Male" 2 "Female"
label values sex sexl

label define marsl 1 "Single" ///
					2 "Married" ///
					3 "Separated" ///
					4 "Divorced" ///
					5 "Widowed"
					
label values maritalstatus marsl

label define studl 1 "yes" 2 "no"

label values student studl

label define hel 1 "Very Good" ///
				2 "Good" ///
				3 "Fair" ///
				4 "Bad" ///
				5 "Very Bad"
				
label values health hel

rename maritalstatus marstat

mvdecode _all, mv(-9)


********************************************************************************
****Simple descriptives of these variables by sex

tab1 sex marstat student health
				

********************************************************************************
****Method 1
****Using esttab but appending
****This works largely but still involved deleting 
****a line and some titles in word

estimates clear			

estpost tab marstat sex, nototal
	
esttab using F:\codefest.rtf, cell(colpct(fmt(2))) ///
     collabels(none) unstack noobs nonumber nomtitle    ///
    eqlabels(, lhs("Marital Status")) replace

estpost tab student sex, nototal

 esttab using F:\codefest.rtf, cell(colpct(fmt(2))) ///
    collabels(none) unstack noobs nonumber nomtitle    ///
    eqlabels(, lhs("Student")) append

estpost tab health sex, nototal

esttab using F:\codefest.rtf, cell(colpct(fmt(2))) ///
    collabels(none) unstack noobs nonumber nomtitle    ///
    eqlabels(, lhs("Student")) append
	 
*Then do some manual alterations in the word file
	 
********************************************************************************
****Method 2
****Improvement in some respects
****Using the -tabout- program

estimates clear

tabout marstat sex using F:\codefest2.rtf, ///
	cells(col) replace

**** Layer up multiple variables Multiple
		
tabout marstat student health sex using F:\codefest4.rtf, ///
		rep c(row) f(1) npos(col) noffs(2)
		
clear
		
****In word still requires manual alterations
****select all
****Insert table
****Convert text to table
****separate by tab

/*
USEFUL URLS:

http://repec.org/bocode/e/estout/advanced.html

http://www.ianwatson.com.au/stata/tabout_tutorial.pdf

*/

*****************************************************************************
* EOF *
