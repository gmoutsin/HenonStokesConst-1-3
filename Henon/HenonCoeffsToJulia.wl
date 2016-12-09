(* ::Package:: *)

Get[NotebookDirectory[]<>"HenonCoeffs.dat"]

storagefile=OpenWrite[NotebookDirectory[]<>"HenonCoeffsList.jl"];

WriteLine[storagefile,"const Nmax = "<> ToString[InputForm[NN]]<>"\n"]
WriteString[storagefile,"const coeffsX = [\n"<>StringReplace[ToString[InputForm[Wx[1]]],"/"->"//"]]

Do[

WriteString[storagefile,",\n"<>StringReplace[ToString[InputForm[Wx[i]]],"/"->"//"]];

,{i,2,NN}]

WriteLine[storagefile,"\n]\n"]



WriteString[storagefile,"const coeffsY = [\n"<>StringReplace[ToString[InputForm[Wy[1]]],"/"->"//"]]

Do[

WriteString[storagefile,",\n"<>StringReplace[ToString[InputForm[Wy[i]]],"/"->"//"]];

,{i,2,NN}]

WriteLine[storagefile,"\n]"]

Close[storagefile];
