*** Codefest 09/10/15
*** Kevin Ralston

*** altered 10/10/15 KR

*** this file produces RTF format output using user written programs, this is funcionality I have never seen before.

**************************************

ssc install rtfutil

ssc install listtab

ssc install sdecode

**************************************

***** read a graph straight out to RTF

 sysuse auto, clear
  scatter mpg weight, by(foreign) scheme(s2color)
  graph export E:\Datasets\rft-teaching-file\myplot1.eps, replace
  tempname handle1
  rtfopen `handle1' using "E:\Datasets\rft-teaching-file\mydoc1.rtf", template(fnmono1) replace
  capture noisily {
  file write `handle1' "{\pard\b Plots of mileage against weight by car origin\par}" _n
  rtflink `handle1' using "myplot1.eps"
  file write `handle1' _n "{\line}" _n "{\pard A package for linking plots like these into RTF documents can be downloaded from Roger Newson's website at {\ul "
  rtfhyper `handle1', hyper("http://www.imperial.ac.uk/nhli/r.newson/")
  file write `handle1' "}\par}"
  file write `handle1' "\line" _n "{\pard Find out more about Stata at "
  rtfhyper `handle1', hyper("http://www.stata.com/") text("{\ul The Stata website}")
  file write `handle1' ".\par}" _n "\line" _n
  }
  rtfclose `handle1'

  
  **** read a tables straight out to RTF
  
  *****************************888
  
   sysuse auto, clear
       keep if foreign==1
       sdecode mpg, replace prefix("\qr{") suffix("}")
       sdecode weight, replace prefix("\qr{") suffix("}")
       tempname handle2
       rtfopen `handle2' using "E:\Datasets\rft-teaching-file\mydoc2.rtf", template(fnmono1) replace
       capture noisily {
       file write `handle2' "{\pard\b Mileage and weight in non-US cars\par}" _n
       rtfrstyle make mpg weight, cwidths(2160 1440 1440) local(b d e)
       listtab make mpg weight, handle(`handle2') begin("`b'") delim("`d'") end("`e'") head("`b'\ql{\i Make}`d'\qr{\i Mileage (mpg)}`d'\qr{\i Weight (lb)}`e'")
       }
       rtfclose `handle2'
	   
	   
********************************************

**** reads results straight out and appends a graph

 sysuse auto, clear
     estpost ta foreign
     esttab using E:\Datasets\rft-teaching-file\mydoc12.rtf, replace
     tempname handle4
     rtfappend `handle4' using E:\Datasets\rft-teaching-file\mydoc12.rtf, replace
     capture noisily {
     scatter mpg weight, by(foreign)
     graph export E:\Datasets\rft-teaching-file\myplot3.eps, replace
     rtflink `handle4' using myplot3.eps
     file write `handle4' "\line"
     }
     rtfclose `handle4'

