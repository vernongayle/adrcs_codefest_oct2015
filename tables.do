global path1 "D:\codefest\"
global path9 "D:\Temp\"

use $path1\stata_ver.dta, clear
sum


tab family, gen(house)
tab economic, gen(eco)



***scalars	
foreach var in house eco	{  
forvalue hhd=1/6 {
eststo: regress `var'`hhd' ibn.sex, nocons coefl
scalar `var'`hhd'm=round(_b[1bn.sex]*100)
scalar `var'`hhd'f=round(_b[2.sex]*100)
count if `var'`hhd'==1
scalar `var'`hhd'c=r(N)
}
}

file open output_1 using $path1\outputs_1.txt, write replace
file write output_1 "Variable" _tab "Male" _tab "Female" _tab "N" _n
foreach var in house eco	{  
forvalues hhd=1/6 {
sum `var'`hhd'
file write output_1 %9s "`var'`hhd'" ///
 _tab %8.0f (`var'`hhd'm) _tab %8.0f (`var'`hhd'f) _tab %8.0f (`var'`hhd'c) _n
}
}
file close output_1

**Need to add something at start to see what is required in table
**add an underscore request
**such as display "" _request(scalar name)
