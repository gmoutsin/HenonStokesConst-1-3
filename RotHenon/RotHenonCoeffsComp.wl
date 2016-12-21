(* ::Package:: *)

(* ::Input:: *)
(*PolynomialToList[pol_]:=Module[{lst={},i,tempmon,tpol},*)
(*tpol=pol+tempmon;*)
(*For[i=1,i<=Length[tpol],i++,AppendTo[lst,tpol[[i]]];];*)
(*Return[Select[lst,!SameQ[#,tempmon]&]]]*)


(* ::Input:: *)
(*NthCoefficientOfPlusOnePowerSeries[c_,m_]:=Total[Table[(-1)^k c[m-k] Binomial[m-1,k],{k,0,m-1}]]*)


(* ::Input:: *)
(*CoeffOfPlusOnePowerSeries[m_]:={NthCoefficientOfPlusOnePowerSeries[Wx,m],NthCoefficientOfPlusOnePowerSeries[Wy,m]}*)


(* ::Input:: *)
(*CoeffOfPowerSeriesInMap[pol_,n_]:=Module[{lst=PolynomialToList[pol]},*)
(*Total[Table[CoeffOfMonomXYProduct[monom,n],{monom,lst}]]]*)
(*SetAttributes[CoeffOfPowerSeriesInMap,Listable]*)


(* ::Input:: *)
(*CoeffOfPowerOfSeries[A_,pow_,deg_]:=Module[{parts=IntegerPartitions[deg,{pow}],res=0},*)
(*Do[res+=(Multinomial@@Table[a,{a,Counts[part]}])(Times@@Table[A[i],{i,part}]);,{part,parts}];*)
(*Return[res]]*)


(* ::Input:: *)
(*CoeffOfMonomX[pow_,deg_]:=CoeffOfMonomX[pow,deg]=CoeffOfPowerOfSeries[Wx,pow,deg]*)
(*CoeffOfMonomY[pow_,deg_]:=CoeffOfMonomY[pow,deg]=CoeffOfPowerOfSeries[Wy,pow,deg]*)


(* ::Input:: *)
(*CoeffOfMonomProductExps[exps_,n_]:=CoeffOfMonomProductExps[exps,n]=Module[{},*)
(*Sum[CoeffOfPowerOfSeries[Wx,exps[[1]],m] CoeffOfPowerOfSeries[Wy,exps[[2]],n-m],{m,1,n-1}]]*)


(* ::Input:: *)
(*CoeffOfMonomXYProduct[monom_,n_]:=Module[{exps=Exponent[monom,{x,y}],cons},*)
(*cons=monom x^-exps[[1]] y^-exps[[2]];*)
(*If[exps[[1]]==0,Return[Expand[cons CoeffOfMonomY[exps[[2]],n]]]];*)
(*If[exps[[2]]==0,Return[Expand[cons CoeffOfMonomX[exps[[1]],n]]]];*)
(*Return[Expand[cons CoeffOfMonomProductExps[exps,n]]]]*)


(* ::Input:: *)
(*Clear[Wx,Wy]*)
(*Wx[1]=0;*)
(*Wy[1]=-4/3;*)
(*Wx[2]=1/Sqrt[3];*)
(*Wy[2]=0;*)
(**)
(*If[FileExistsQ[Directory[]<>"/RotHenonCoeffs.dat"],*)
(*Get[Directory[]<>"/RotHenonCoeffs.dat"]];*)


(* ::Input:: *)
(*If[FileExistsQ[Directory[]<>"/RotHenonCoeffs.dat"],*)
(*storagefile=OpenAppend[Directory[]<>"/RotHenonCoeffs.dat"];*)
(*Print["File exists!"];,*)
(*storagefile=OpenWrite[Directory[]<>"/RotHenonCoeffs.dat"];*)
(*Print["File doesn't exist!"];*)
(*WriteString[storagefile,"NN=0;\n"];*)
(*Do[*)
(*WriteString[storagefile,"Wx["<>ToString[i,InputForm]<>"]="<>ToString[Wx[i],InputForm]<>";\n"];*)
(*WriteString[storagefile,"Wy["<>ToString[i,InputForm]<>"]="<>ToString[Wy[i],InputForm]<>";NN++;\n"];*)
(*,{i,1,2}];*)
(*NN=2;*)
(*]*)


(* ::Input:: *)
(*h[x_,y_]:=Evaluate[{{Cos[a],-Sin[a]},{Sin[a],Cos[a]}}.{x,y-x^2}/.a->2\[Pi]/3//Expand]*)
(*Henon[x_,y_]:=Evaluate[Expand[h@@h@@h[x,y]]];*)


(* ::Input:: *)
(*Nmax=10;*)


(* ::Input:: *)
(*time=Timing[*)
(*Do[*)
(*Print[counter];*)
(*sol=Solve[CoeffOfPlusOnePowerSeries[counter+1]-CoeffOfPowerSeriesInMap[Henon[x,y],counter+1]==0,{Wx[counter],Wy[counter]}];*)
(*Wx[counter]=(Wx[counter]/.sol[[1]]);*)
(*Wy[counter]=(Wy[counter]/.sol[[1]]);.*)
(*WriteString[storagefile,"Wx["<>ToString[counter,InputForm]<>"]="<>ToString[Wx[counter],InputForm]<>";\n"];*)
(*WriteString[storagefile,"Wy["<>ToString[counter,InputForm]<>"]="<>ToString[Wy[counter],InputForm]<>";NN++;\n"];*)
(*,{counter,NN+1,NN+Nmax}]][[1]];*)
(**)
(*Print[time]*)


(* ::Input:: *)
(*Close[storagefile];*)
