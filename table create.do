*** Create a table descriptive ***
** Z Feng **
** 9 Oct 2015 **

use c:/work/d_drive/xiaoqi/au_visit/data/Scotland_teaching_file_1_PCT,clear

des

************************************************
recode health (1/3=0) (4/5=1),g(poor_health)

lab def poor_health 0 "very good/good health" 1 "poor health"
lab val poor_health poor_health

tab health poor_health

tab age poor_health
return list

*drop newvar
egen newvar=group(age poor_health), label

tab newvar

tab age,nolab
tab poor_health

g n=1
collapse (sum)n,by(age poor_health) 

help reshape

reshape wide n,i(age) j(poor_health)

g rtot=n0+n1
g n0_pct=n0/rtot*100
g n1_pct=n1/rtot*100

lab var n0 "N good health"
lab var n1 "N poor health"

lab var n0_pct "good health"
lab var n1_pct "poor health"

keep age n0_pct n1_pct rtot
order age n0_pct n1_pct rtot
sav agebyhealth,replace

***
use c:/work/d_drive/xiaoqi/au_visit/data/Scotland_teaching_file_1_PCT,clear

des

************************************************
recode health (1/3=0) (4/5=1),g(poor_health)

lab def poor_health 0 "very good/good health" 1 "poor health"
lab val poor_health poor_health

g n=1
collapse (sum)n,by(Ethnic_Group poor_health) 


reshape wide n,i(Ethnic_Group) j(poor_health)

g rtot=n0+n1
g n0_pct=n0/rtot*100
g n1_pct=n1/rtot*100

lab var n0 "N good health"
lab var n1 "N poor health"

lab var n0_pct "good health"
lab var n1_pct "poor health"

keep Ethnic_Group n0_pct n1_pct rtot
order Ethnic_Group n0_pct n1_pct rtot
sav Ethnic_Groupbyhealth,replace


use agebyhealth,replace
append using  Ethnic_Groupbyhealth

help decode

decode age, g(agestring)
decode Ethnic_Group, g(Ethnic_Groupstring)

replace agestring=Ethnic_Groupstring if agestring=="" 

drop Age
drop Ethnic

g str20 Age="Age" if agestring~=""
g str20 Ethnic="Ethnic Group" if Ethnic_Groupstring~=""


keep Age Ethnic agestring n0_pct n1_pct rtot

replace Age="Ethnic Group" if Ethnic~=""

ren Age Variable
drop Ethnic

order Variable agestring n0_pct n1_pct rtot
save createdTable,replace

***********************
**EOF*
