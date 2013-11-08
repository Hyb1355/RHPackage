(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



BeginPackage[$CommonPackage];


ZeroMatrix;OuterProduct;
Second:=#[[2]]&;
SparseZeroMatrix;
SparseIdentityMatrix;
DiagonalMatrixQ;

RealLeastSquares;
Begin["Private`"];
ZeroMatrix[]=0;
ZeroMatrix[n_]:=0 IdentityMatrix[n];
ZeroMatrix[n_,m_]:=0 IdentityMatrix[Max[n,m]][[1;;n,1;;m]];
SparseZeroMatrix[n_,m_]:=SparseArray[{},{n,m}];
SparseIdentityMatrix[n_]:=SparseArray[{i_,i_}->1,{n,n}];
OuterProduct[f_List,g_List]:=Transpose[Map[# f&,g]];
OuterProduct[f_List,g_]:=f g;
DiagonalMatrixQ[DD_?MatrixQ]:=Norm[DD-DiagonalMatrix[Diagonal[DD]]]==0;
DiagonalMatrixQ[_]:=False;
End[];


ToRotatedList;Index;FirstIndex;IndexRange;IncreaseIndexRange;SetIndexRange;DropNegative;
SetAttributes[ShiftList,NHoldRest];
ToList;
NegativeList;
NonPositiveList;
NonNegativeList;
PositiveList;
NegativeShiftList;
NonNegativeShiftList;
NonPositiveShiftList;
PositiveShiftList;
ZeroShiftList;
ShiftRight;
ShiftLeft;
GrowShiftRight;
GrowShiftLeft;
ShiftTable;
RiffleList;
Indices;
ShiftMatrix;
LastIndex;
LaurentMatrix;
BasisShiftList;
ReplaceEntry;
CirculantMatrix;
IncreaseSize;
Begin["Private`"];

fixind[a_Integer,ind_]:=a+ind;
fixind[All,ind_]:=All;
fixind[All;;b_Integer,ind_]:=1;;b+ind;
fixind[a_Integer;;b_Integer,ind_]:=a+ind;;b+ind;
fixind[a_Integer;;All,ind_]:=a+ind;;All;
fixind[All;;All,ind_]:=1;;All;

fixind[a_Integer,ind_,n_]:=Mod[a+ind-1,n]+1;
fixind[All,ind_,n_]:=All;
fixind[All;;b_Integer,ind_,n_]:=1;;fixind[b,ind,n];
fixind[a_Integer;;b_Integer,ind_,n_]:=fixind[a,ind,n];;fixind[b,ind,n];
fixind[a_Integer;;All,ind_,n_]:=fixind[a,ind,n];;All;
fixind[All;;All,ind_,n_]:=1;;All;


ShiftList/:ShiftList[ln_List,ind_Integer][[j_]]:=ln[[fixind[j,ind,Length[ln]]]];
ShiftList[ln_List,lp_List]:=ShiftList[Join[ln,lp],Length[ln]+1];


ToList[ShiftList[ln_,_]]:=ln;
ShiftList/:Length[l_ShiftList]:=l//ToList//Length;
ToRotatedList[ShiftList[ln_,ind_]]:=RotateLeft[ln,ind-1];
Index[ShiftList[_,ind_]]:=ind;
FirstIndex[l_ShiftList]:=1-Index[l];
LastIndex[l_ShiftList]:=Length[l]-Index[l];
IndexRange[l_ShiftList]:={FirstIndex[l],LastIndex[l]};

IncreaseIndexRange[sl_ShiftList,ind_]:=Module[{sl2},
sl2=PadLeft[sl,Length[sl]+Max[0,FirstIndex[sl]-First[ind]]];
PadRight[sl2,Length[sl2]+Max[0,Last[ind]-LastIndex[sl]]]
];
SetIndexRange[sl_ShiftList,ind_]:=Module[{sl2},
sl2=PadLeft[sl,Length[sl]+FirstIndex[sl]-First[ind]];
PadRight[sl2,Length[sl2]+Last[ind]-LastIndex[sl]]
];

FFTIndexRange[n_?OddQ]:={-(n-1)/2,(n-1)/2};
FFTIndexRange[n_?EvenQ]:={-n/2,n/2-1};

ReverseKeepIndexRange[sl_ShiftList]:=SetIndexRange[Reverse[sl],IndexRange[sl]];

DropNegative[l_ShiftList]:=ShiftList[l[[0;;Length[l]-Index[l]]],1];

Drop[l_ShiftList,n_]^:=ShiftList[Drop[l//ToList,n],Index[l]-n];

NegativeList[ShiftList[ln_,ind_]]:=ln[[1;;ind-1]];
NonPositiveList[ShiftList[ln_,ind_]]:=ln[[1;;ind]];
NonNegativeList[ShiftList[ln_,ind_]]:=ln[[ind;;-1]];
PositiveList[ShiftList[ln_,ind_]]:=ln[[ind+1;;-1]];
NegativeShiftList[l_ShiftList]:=ShiftList[NegativeList[l],Array[0 ToList[l][[1]]&,Length[NonNegativeList[l]]]];
NonNegativeShiftList[l_ShiftList]:=ShiftList[Array[0 ToList[l][[1]]&,Length[NegativeList[l]]] ,NonNegativeList[l]];
NonPositiveShiftList[l_ShiftList]:=ShiftList[NegativeList[l],Join[{l[[0]]},Array[0 ToList[l][[1]]&,Length[PositiveList[l]]] ]];
PositiveShiftList[l_ShiftList]:=ShiftList[Array[0 ToList[l][[1]]&,Length[NegativeList[l]]],Join[{0 ToList[l][[1]]},PositiveList[l]]];
ZeroShiftList[l_ShiftList]:=ShiftList[Array[0 ToList[l][[1]]&,Length[NegativeList[l]]],Join[{l[[0]]},Array[0 ToList[l][[1]]&,Length[PositiveList[l]]] ]];


ln_ShiftList+ln2_ShiftList^:=Module[{lnn,lnn2},
lnn=IncreaseIndexRange[ln,IndexRange[ln2]];
lnn2=IncreaseIndexRange[ln2,IndexRange[ln]];
ShiftList[ToList[lnn]+ToList[lnn2],Index[lnn]]];
ShiftList/:Plus[c_,ShiftList[ln_,ind_]]:=ShiftList[ln+c,ind];
ShiftList/:Dot[sl1_ShiftList,sl2_ShiftList]:=Module[{indm,indM},
indm=Max[FirstIndex[sl1],FirstIndex[sl2]];
indM=Min[LastIndex[sl1],LastIndex[sl2]];
If[indM<indm,
0,
sl1[[indm;;indM]].sl2[[indm;;indM]]
]
];
ShiftList/:Times[ShiftList[ln_,ind_],ShiftList[ln2_,ind_]]:=ShiftList[ ln ln2, ind];
ShiftList/:Times[c_,ShiftList[ln_,ind_]]:=ShiftList[c ln,ind];
ShiftList/:ListConvolve[a_ShiftList,b_ShiftList,opts___]:=ShiftList[ListConvolve[ToList[a],ToList[b],opts],Index[a]];
ShiftList/:RotateLeft[a_ShiftList,opts___]:=ShiftList[RotateLeft[ToList[a],opts],Index[a]];


PadRight[f_ShiftList,n_]^:=ShiftList[PadRight[ToList[f],n,{If[Length[f]==0,0,ToList[f][[1]] 0]}],Index[f]];
PadLeft[f_ShiftList,n_]^:=ShiftList[PadLeft[ToList[f],n,{If[Length[f]==0,0,ToList[f][[1]] 0]}],Index[f]+n-Length[f]];
ShiftRight[f_ShiftList]:=ShiftList[ToList[f],Index[f]-1];
ShiftLeft[f_ShiftList]:=ShiftList[ToList[f],Index[f]+1];
ShiftLeft[f_ShiftList,d_]:=ShiftList[ToList[f],Index[f]+d];
ShiftRight[f_ShiftList,d_]:=ShiftList[ToList[f],Index[f]-d];
GrowShiftRight[f_ShiftList]:=ShiftRight[PadLeft[f,Length[f]+1]];
GrowShiftLeft[f_ShiftList]:=ShiftLeft[PadRight[f,Length[f]+1]];

Append[f_ShiftList,el_]^:=ShiftList[Append[f//ToList,el],f//Index];



RiffleList[l_List,l2_List]:=Module[{Foo},Riffle[l,Foo@@l2]/.Foo->Sequence];
Riffle[sl_ShiftList,x_]^:=ShiftList[Riffle[ToList[sl],x],Index[sl] 2 -1];
RiffleList[sl_ShiftList,l2_List]:=ShiftList[RiffleList[ToList[sl],l2],Index[sl](1+Length[l2]) -Length[l2]];

Reverse[sl_ShiftList]^:=ShiftList[sl//ToList//Reverse,Length[sl]-Index[sl]+1];


Format[ShiftList[l_,ind_Integer]]:=If[0<ind<Length[l],Join[l[[1;;ind-1]],{Style[l[[ind]],Bold]},l[[ind+1;;-1]]],
l];
MatrixForm[ShiftList[l_,ind_Integer]]^:=Join[l[[1;;ind-1]],{Style[l[[ind]],Bold]},l[[ind+1;;-1]]]//MatrixForm;


ShiftList/:Apply[f_,ShiftList[l_,_]]:=Apply[f,l];ShiftList/:Map[f_,ShiftList[l_,ind_]]:=ShiftList[Map[f,l],ind];
ShiftList/:MapIndexed[f_,ShiftList[ln_,ind_]]:=ShiftList[MapIndexed[f[#1,#2-ind]&,ln],ind];
SetAttributes[ShiftTable,HoldFirst];
ShiftTable[h_,{v_,m_,p_}]:=ShiftList[Table[h,{v,m,-1}],Table[h,{v,0,p}]];
BasisShiftList[ln_ShiftList,k_]:=ShiftList[BasisVector[Length[ln]][k+Index[ln]],Index[ln]];

BasisShiftList[i_;;j_,k_]:=ShiftList[BasisVector[j-i+1][k-i+1],1-i];


ReplacePart[sl_ShiftList,pat_]^:=ShiftList[MapIndexed[If[Apply[Or,Map[Function[pm,MatchQ[First[#2]-Index[sl],pm]],Map[First,pat]]],First[#2]-Index[sl]/.pat,#1]&,ToList[sl]],Index[sl]];

ReplaceEntry[sl_ShiftList,i_,p_,OptionsPattern[IncreaseSize->False]]:=Module[{sl2,sll},
If[!OptionValue[IncreaseSize]&&(i>LastIndex[sl]||i<FirstIndex[sl]),
Throw["ReplaceEntry: Increase Size is false"];];
sl2=IncreaseIndexRange[sl,{i,i}];


sll=sl2//ToList;
sll[[i+Index[sl2]]]=p;
ShiftList[sll,sl2//Index]];
Abs[f_ShiftList]^:=Map[Abs,f];
Re[f_ShiftList]^:=Map[Re,f];
Im[f_ShiftList]^:=Map[Im,f];


Indices[sl_ShiftList]^:=Array[#-Index[sl]&,Length[sl]];LinePlot[sl_ShiftList,opts___]^:=ListLinePlot[Thread[List[Indices[sl],ToList[sl]]],opts];
ListLogPlot[sl_ShiftList,opts___]^:=ListLogPlot[Thread[List[Indices[sl],ToList[sl]]],opts];
LineLogPlot[sl_ShiftList,opts___]:=ListLineLogPlot[Thread[List[Indices[sl],ToList[sl]]],opts];


ReImLinePlot[sl_ShiftList,opts___]:=ReImListLinePlot[Thread[List[Indices[sl],ToList[sl]]],opts];
ReImLineLogPlot[sl_ShiftList,opts___]:=ReImListLineLogPlot[Thread[List[Indices[sl],ToList[sl]]],opts];
ReImLogPlot[sl_ShiftList,opts___]:=ReImListLogPlot[Thread[List[Indices[sl],ToList[sl]]],opts];


ShiftList/:ToeplitzMatrix[sl_ShiftList,n_Integer]:=ToeplitzMatrix[PadRight[NonPositiveList[sl]//Reverse,n],PadRight[NonNegativeList[sl],n]]//Transpose;
ToeplitzMatrix[sl_ShiftList]^:=ToeplitzMatrix[sl,Length[sl]];
LaurentMatrix[lg_,{im_,iM_}]:=ShiftMatrix[ToeplitzMatrix[lg,iM-im+1],{1-im,1-im}];
LaurentMatrix[lg_ShiftList]:=ShiftMatrix[ToeplitzMatrix[lg,Length[lg]],lg//IndexRange];
CirculantMatrix[sl_ShiftList,n_]:=ToeplitzMatrix[PadRight[NonPositiveList[sl]//Reverse,n]+PadLeft[PositiveList[sl]//Reverse,n],PadRight[NonNegativeList[sl],n]+PadLeft[NegativeList[sl],n]];



NZeroQ[sl_List]:=sl//Abs//Max//NZeroQ;
NZeroQ[sl_ShiftList]:=sl//ToList//NZeroQ;

End[];


ShiftMatrix;
ToArray;
RangeIndex;
DomainIndex;
ShiftDiagonalMatrix;
SparseShiftMatrix;
RowIndex;
ColumnIndex;
RowIndexRange;
ColumnIndexRange;
Begin["Private`"];



ShiftMatrix/:ShiftMatrix[ls_?MatrixQ,{iind_,jind_}][[i_,j_]]:=ls[[fixind[i,iind],fixind[j,jind]]];
ShiftMatrix/:ShiftMatrix[ls_?MatrixQ,{iind_,jind_}][[i_Integer]]:=ShiftList[ls[[fixind[i,iind]]],jind];
ShiftMatrix/:f_/@ShiftMatrix[ls_?MatrixQ,{iind_,jind_}]:=f[ShiftList[#,jind]]&/@ls;
ShiftMatrix/:Transpose[ShiftMatrix[ls_?MatrixQ,{iind_,jind_}]]:=ShiftMatrix[ls//Transpose,{jind,iind}];
ShiftMatrix/:Inverse[ShiftMatrix[ls_?MatrixQ,{iind_,jind_}]]:=ShiftMatrix[ls//Inverse,{jind,iind}];



ToArray[ShiftMatrix[ls_,{_,_}]]:=ls;
Normal[sl_ShiftMatrix]^:=sl//ToArray;


ShiftMatrix/:Dimensions[ShiftMatrix[ls_?MatrixQ,{_,_}]]:=Dimensions[ls];

RowIndex[ShiftMatrix[ls_?MatrixQ,{iind_,jind_}]]:=iind;
ColumnIndex[ShiftMatrix[ls_?MatrixQ,{iind_,jind_}]]:=jind;

RangeIndex:=RowIndex;
DomainIndex:=ColumnIndex;


RowIndexRange[l_ShiftMatrix]:={1-RowIndex[l],Dimensions[l][[1]]-RowIndex[l]};
ColumnIndexRange[l_ShiftMatrix]:={1-ColumnIndex[l],Dimensions[l][[2]]-ColumnIndex[l]};

ShiftMatrix/:PadRight[sm_ShiftMatrix,{m_,n_}]:=ShiftMatrix[PadRight[ToArray[sm],{m+RowIndex@sm,n+ColumnIndex@sm}],{RowIndex@sm,ColumnIndex@sm}];
ShiftMatrix/:PadLeft[sm_ShiftMatrix,{m_,n_}]:=ShiftMatrix[PadLeft[ToArray[sm],{Length@ToArray@sm-RowIndex@sm+1-m,Second@Dimensions@ToArray@sm-ColumnIndex@sm+1-n}],{1-m,1-n}];
SetIndexRange[sm_ShiftMatrix,{i_,j_},{m_,n_}]:=PadRight[PadLeft[sm,{i,m}],{j,n}];



Format[sm:ShiftMatrix[_?MatrixQ,{_Integer,_Integer}]]:=Module[{i,j},
Table[If[i==0||j==0,Style[sm[[i,j]],Bold],sm[[i,j]]],{i,RowIndexRange[sm][[1]],RowIndexRange[sm][[2]]},{j,ColumnIndexRange[sm][[1]],ColumnIndexRange[sm][[2]]}]]//MatrixForm


ShiftMatrix/:sm_ShiftMatrix.sl_ShiftList:=ShiftList[ToArray[sm].ToList[sl],RangeIndex[sm]];
ShiftMatrix/:sl_ShiftList.sm_ShiftMatrix:=ShiftList[ToList[sl].ToArray[sm],ColumnIndex[sm]];
ShiftMatrix/:sm_ShiftMatrix.sm2_ShiftMatrix:=ShiftMatrix[ToArray[sm].ToArray[sm2],{RangeIndex[sm],DomainIndex[sm2]}];
ShiftMatrix/:sm_ShiftMatrix+sm2_ShiftMatrix:=ShiftMatrix[ToArray[sm]+ToArray[sm2],{RangeIndex[sm],DomainIndex[sm2]}];
ShiftMatrix/:c_?NumberQ sm_ShiftMatrix:=ShiftMatrix[c ToArray[sm],{RangeIndex[sm],DomainIndex[sm]}];


ShiftDiagonalMatrix[A_,B_]:=ShiftMatrix[BlockDiagonalMatrix[{A,B}],Dimensions[A]+1];

ShiftMatrix[{A_?MatrixQ,B_?MatrixQ}]:=ShiftMatrix[A~RightJoin~B,{1,Dimensions[A][[2]]+1}];

ShiftMatrix/:LinearSolve[sm_ShiftMatrix,sl_ShiftList]:=ShiftList[LinearSolve[sm//ToArray,sl//ToList],sm//DomainIndex];


SparseShiftMatrix[ls_Rule,{im_,iM_},{jm_,jM_}]:=SparseShiftMatrix[{ls},{im,iM},{jm,jM}];
SparseShiftMatrix[ls_List,{im_,iM_},{jm_,jM_}]:=Module[{i,j},
ShiftMatrix[Table[{i,j}/.ls/.{_,_}->0,{i,im,iM},{j,jm,jM}],{1-im,1-jm}]
]
SparseShiftMatrix[ls_,{im_,iM_}]:=SparseShiftMatrix[ls,{im,iM},{im,iM}];


ShiftMatrix/:Re[ShiftMatrix[ls_?MatrixQ,ind_]]:=ShiftMatrix[ls//Re,ind];
ShiftMatrix/:Im[ShiftMatrix[ls_?MatrixQ,ind_]]:=ShiftMatrix[ls//Im,ind];






End[];



RemoveZeros;
RemoveNZeros;
ChopDrop;

Begin["Private`"];
RemoveZeros[{v___,_?(Norm[#]==0&)}]:=RemoveZeros[{v}];
RemoveZeros[v_List]:=v;

RemoveZeros[ShiftList[{v___,_?(Norm[#]==0&)},ind_]]:=RemoveZeros[ShiftList[{v},ind]];
RemoveZeros[ShiftList[{_?(Norm[#]==0&),v___},ind_]]:=RemoveZeros[ShiftList[{v},ind-1]];
RemoveZeros[v_ShiftList]:=v;

RemoveNZeros[{v___,_?NZeroQ}]:=RemoveNZeros[{v}];
RemoveNZeros[v_List]:=v;

RemoveNZeros[ShiftList[{v___,_?NZeroQ},ind_]]:=RemoveNZeros[ShiftList[{v},ind]];
RemoveNZeros[ShiftList[{_?NZeroQ,v___},ind_]]:=RemoveNZeros[ShiftList[{v},ind-1]];
RemoveNZeros[v_ShiftList]:=v;


ChopDrop[v_]:=v//Chop//RemoveZeros;
ChopDrop[v_,prec_]:=Chop[v,prec]//RemoveZeros;
End[];


ApplyAll;
ColumnMap;
VectorTranspose;

Begin["Private`"];
ApplyAll[{},m_]:=m;ApplyAll[fs_,m_]:=First[fs][ApplyAll[Rest[fs],m]];
ColumnMap[f_,m_?VectorQ]:=Map[f,m]//VectorTranspose;
ColumnMap[f_,m_?MatrixQ]:=Map[f,Transpose[m]]//VectorTranspose;
End[];


MapOuter;MapDot;

Begin["Private`"];
ToList[ln_List]:=ln;
MapOuter[m_,lst_]:=MapIndexed[m[First[#2]]~SDot~#1&,lst];
MapDot[f_,ls_List]:=Module[{k},\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(k = 1\), \(Length[ls]\)]\(ls[[k]] f[k]\)\)];
MapDot[m_,lst_ShiftList]:=Module[{k},\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(k = FirstIndex[lst]\), \(LastIndex[lst]\)]\(lst[[k]] m[k]\)\)];

VectorTranspose[f_?MatrixQ]:=Transpose[f];
VectorTranspose[f_]:=f;
End[];



GaussianElimination;

MatrixMap;

ArrayMap;

SortEigensystem;
SortEigenvalues;

ToListOfMatrices;
ToMatrixOfLists;


ToArrayOfLists;

ToListOfArrays;

ToShiftListOfMatrices;
ToMatrixOfShiftLists;
SVD:=SingularValueDecomposition;


ConditionNumber;

AlternatingTotal;

PartitionList;


RightJoin;

BlockDiagonalMatrix;

ToShiftListOfArrays;
ToArrayOfShiftLists;


Begin["Private`"];

AlternatingTotal[lst_]:=MapDot[(-1)^(#-1)&,lst];


GaussianElimination[m_List?MatrixQ,v_List?VectorQ]:=Last/@RowReduce[Flatten/@Transpose[{m,v}]]

MatrixMap[f_,m_]:=Map[f,m,{2}];

ArrayMap[f_,m_?MatrixQ]:=MatrixMap[f,m];
ArrayMap[f_,m_?VectorQ]:=f/@m;
ArrayMap[f_,m_?TensorQ]:=MatrixMap[f,#]&/@m;
ArrayMap[f_,m_ShiftList]:=ArrayMap[f,m//ToArrayOfShiftLists];
ArrayMap[f_,m_]:=f[m];

SortEigensystem[A_]:=({#[[1]],Map[Function[vec,Exp[-I Arg[First[vec]]]],#[[2]]]#[[2]] }&)[Sort[Thread[Eigensystem[A]]]//Thread];
SortEigenvalues[A_]:=Sort[Eigenvalues[A]];

ToListOfMatrices[gg_]:=Array[gg[[All,All,#]]&,Length[gg//First//First]];
ToMatrixOfLists[g1_]:=Array[g1[[All,#1,#2]]&,Dimensions[First[g1]]];


ToArrayOfLists[A_?MatrixQ]:=A//Transpose;
ToArrayOfLists[A_?(Length[Dimensions[#]]==3&)]:=A//ToMatrixOfLists;
ToArrayOfLists[A_?VectorQ]:=A;

ToListOfArrays[A_?MatrixQ]:=A//Transpose;
ToListOfArrays[A_?(Length[Dimensions[#]]==3&)]:=A//ToListOfMatrices;
ToListOfArrays[A_?VectorQ]:=A;

ToShiftListOfMatrices[l_]:=ShiftList[Thread[ToList/@l],Index[First[l]]];
ToMatrixOfShiftLists[l_]:=Map[ShiftList[#,Index[l]]&,Thread[ToList[l]]];

ToShiftListOfArrays[ar_]:=ShiftList[ToListOfArrays[ArrayMap[ToList,ar]],Flatten[ar][[1]]//Index];
ToArrayOfShiftLists[sl_]:=Map[ShiftList[#,Index[sl]]&,ToArrayOfLists[ToList[sl]],{-2}];


SVD:=SingularValueDecomposition;
Second:=#[[2]]&;

ConditionNumber[m_]:=#1/#2&@@Diagonal[SVD[m//Chop][[2]]][[{1,-1}]];



PartitionList[l_,{}]:={};
PartitionList[l_,d_?VectorQ]:=Join[{l[[;;First[d]]]},PartitionList[l[[First[d]+1;;-1]],Rest[d]]];
PartitionList[l_,d_?MatrixQ]:=PartitionList[PartitionList[l,Flatten[d]],Length/@d];


RightJoin[v__]:=Join@@(VectorTranspose/@{v})//VectorTranspose;

BlockDiagonalMatrix[Al_List]:=Module[{Asp,k,j,dim,sete},
dim[al_?MatrixQ]:=al//Dimensions;
dim[al_?VectorQ]:={al//Length,1};
dim[al_]:={1,1};
Asp=SparseZeroMatrix@@(dim/@Al//Total);

{k,j}={0,0};
sete[A_?MatrixQ]:=Asp[[k+1;;(k=k+Dimensions[A][[1]]),j+1;;(j=j+Dimensions[A][[2]])]]=A;
sete[A_?VectorQ]:=Asp[[k+1;;(k=k+Length[A]),j+1;;(j=j+1)]]=A;
sete[A_]:=Asp[[k+1;;(k=k+1),j+1;;(j=j+1)]]=A;

sete/@Al;
Asp
];

LeastSquaresQR[A_,b_]:=Module[{Q,R},
{Q,R}=A//QRDecomposition;
LeastSquares[R,Q.b]];


ShiftLeft[l_List]:=Rest[l];
ShiftRight[l_List]:=Join[{0},Most[l]];
ShiftLeft[l_List,k_]:=l[[k+1;;]];
GrowShiftLeft[l_List]:=PadRight[ShiftLeft[l],Length[l]];
GrowShiftLeft[l_List,k_]:=PadRight[ShiftLeft[l,k],Length[l]];
GrowShiftRight[l_List]:=Join[{0},l];


End[];


PLUDecomposition;
PULDecomposition;
QLDecomposition;
LQDecomposition;
RQDecomposition;

Begin["Private`"];

PLUDecomposition[M_]:=Module[{lu,p,c,n},
n=M//Length;
{lu,p,c}=M//LUDecomposition;
{IdentityMatrix[n][[p]]\[Transpose],
lu SparseArray[{i_,j_}/;j<i->1,{n,n}]+IdentityMatrix[n],
lu SparseArray[{i_,j_}/;j>=i->1,{n,n}]}];

PULDecomposition[M_]:=Module[{P,L,U},
{P,L,U}=(Reverse/@M//Reverse//PLUDecomposition);
{Reverse/@P//Reverse,Reverse/@L//Reverse,Reverse/@U//Reverse}];

QLDecomposition[A_]:=Module[{Q,R},
{Q,R}=Reverse/@A//Reverse//QRDecomposition;
{Reverse/@Transpose[Q]//Reverse//Transpose,Reverse/@R//Reverse}
];
LQDecomposition[A_]:=Module[{Q,R},
{Q,R}=A//Transpose//QRDecomposition;
{R//Transpose,Q//Transpose}
];
RQDecomposition[A_]:=Module[{Q,L},
{Q,L}=A//Transpose//QLDecomposition;
{L//Transpose,Q//Transpose}
];
End[];



BlockRow;BlockMatrix;SparseDiagonalMatrix;

Begin["Private`"];


CIdentityMatrix[n_,m_]:=IdentityMatrix[Max[n,m]][[1;;n,1;;m]];
CIdentityMatrix[n_]:=IdentityMatrix[n];
CIdentityMatrix[]=1;


MaxRowDimension[B_]:=Max/@Thread[Select[Dimensions/@MakeMatrix/@B,#!={}&]];


ScalarFlatten[p_List,vars___]:=Flatten[p,vars];
ScalarFlatten[p_,vars___]:=p;
MakeMatrix[p_]/;VectorQ[p]:={p};
MakeMatrix[p_]/;MatrixQ[p]:=p;
MakeMatrix[p_]:={{p}};
BlockRowBack[M_]:=Map[ScalarFlatten[#,1]&,Thread[Join[M]]]//MakeMatrix;



BlockRow[B_]:=Module[{dms},
dms=MaxRowDimension[B];
 Block[{e,o},
e[k_]:=CIdentityMatrix[dms[[1]],1];
o:=ZeroMatrix[dms[[1]],1];
Map[Which[#===0||#===Null,
		ZeroMatrix@@dms,
		#===1,
		CIdentityMatrix@@dms,
		True,
		#]&,B]]//BlockRowBack]


BlockMatrix[A_]:=Flatten[(BlockRow/@A),1];
SparseDiagonalMatrix[l_List]:=Module[{i},SparseArray[{i_,i_}:>l[[i]],Length[l]{1,1}]];



RealLeastSquares[A_,b_]:=LeastSquares[Join[Re[A],Im[A]],Join[Re[b],Im[b]]]


End[];
EndPackage[];
