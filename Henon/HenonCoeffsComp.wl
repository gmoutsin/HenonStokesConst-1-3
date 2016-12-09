(* ::Package:: *)

PolynomialToList[pol_]:=Module[{lst={},i,tempmon,tpol},
tpol=pol+tempmon;
For[i=1,i<=Length[tpol],i++,AppendTo[lst,tpol[[i]]];];
Return[Select[lst,!SameQ[#,tempmon]&]]]


NthCoefficientOfPlusOnePowerSeries[c_,m_]:=Total[Table[(-1)^k c[m-k] Binomial[m-1,k],{k,0,m-1}]]


CoeffOfPlusOnePowerSeries[m_]:={NthCoefficientOfPlusOnePowerSeries[Wx,m],NthCoefficientOfPlusOnePowerSeries[Wy,m]}


CoeffOfPowerSeriesInMap[pol_,n_]:=Module[{lst=PolynomialToList[pol]},
Total[Table[CoeffOfMonomXYProduct[monom,n],{monom,lst}]]]
SetAttributes[CoeffOfPowerSeriesInMap,Listable]


CoeffOfPowerOfSeries[A_,pow_,deg_]:=Module[{parts=IntegerPartitions[deg,{pow}],res=0},
Do[res+=(Multinomial@@Table[a,{a,Counts[part]}])(Times@@Table[A[i],{i,part}]);,{part,parts}];
Return[res]]


CoeffOfMonomX[pow_,deg_]:=CoeffOfMonomX[pow,deg]=CoeffOfPowerOfSeries[Wx,pow,deg]
CoeffOfMonomY[pow_,deg_]:=CoeffOfMonomY[pow,deg]=CoeffOfPowerOfSeries[Wy,pow,deg]


CoeffOfMonomProductExps[exps_,n_]:=CoeffOfMonomProductExps[exps,n]=Module[{},
Sum[CoeffOfPowerOfSeries[Wx,exps[[1]],m] CoeffOfPowerOfSeries[Wy,exps[[2]],n-m],{m,1,n-1}]]


CoeffOfMonomXYProduct[monom_,n_]:=Module[{exps=Exponent[monom,{x,y}],cons},
cons=monom x^-exps[[1]] y^-exps[[2]];
If[exps[[1]]==0,Return[Expand[cons CoeffOfMonomY[exps[[2]],n]]]];
If[exps[[2]]==0,Return[Expand[cons CoeffOfMonomX[exps[[1]],n]]]];
Return[Expand[cons CoeffOfMonomProductExps[exps,n]]]]


Clear[Wx,Wy]
Wx[1]=0;
Wy[1]=2/3;
Wx[2]=-(1/6);
Wy[2]=0;

If[FileExistsQ[Directory[]<>"/HenonCoeffs.dat"],
Get[Directory[]<>"/HenonCoeffs.dat"]];


If[FileExistsQ[Directory[]<>"/HenonCoeffs.dat"],
storagefile=OpenAppend[Directory[]<>"/HenonCoeffs.dat"];,
storagefile=OpenWrite[Directory[]<>"/HenonCoeffs.dat"];
WriteString[storagefile,"NN=0;\n"];
Do[
WriteString[storagefile,"Wx["<>ToString[i,InputForm]<>"]="<>ToString[Wx[i],InputForm]<>";\n"];
WriteString[storagefile,"Wy["<>ToString[i,InputForm]<>"]="<>ToString[Wy[i],InputForm]<>";NN++;\n"];
,{i,1,2}];
NN=2;
]


h[x_,y_]:={x+2 y+3/4 (1-(x+1+y)^2),y+3/4 (1-(x+1+y)^2)}
Henon[x_,y_]:=Evaluate[Expand[h@@h@@h[x,y]]];


Nmax=10;


time=Timing[
Do[
Print[counter];
sol=Solve[CoeffOfPlusOnePowerSeries[counter+1]-CoeffOfPowerSeriesInMap[Henon[x,y],counter+1]==0,{Wx[counter],Wy[counter]}];
Wx[counter]=(Wx[counter]/.sol[[1]]);
Wy[counter]=(Wy[counter]/.sol[[1]]);.
WriteString[storagefile,"Wx["<>ToString[counter,InputForm]<>"]="<>ToString[Wx[counter],InputForm]<>";\n"];
WriteString[storagefile,"Wy["<>ToString[counter,InputForm]<>"]="<>ToString[Wy[counter],InputForm]<>";NN++;\n"];
,{counter,NN+1,Nmax}]][[1]];

Print[time]


Close[storagefile];
