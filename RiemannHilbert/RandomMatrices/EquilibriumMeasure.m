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



BeginPackage["RiemannHilbert`RandomMatrices`",{"RiemannHilbert`","RiemannHilbert`Common`"}];


PlotEquilibriumMeasure;
EquilibriumMeasureSupport::usage="EquilibriumMeasureSupport[V] Computes the support of the equilibrium measure (currently only for convex V";
EquilibriumMeasure::usage="EquilibriumMeasure[V,x] Computes the equilibrium measure at a point x inside the support";
EquilibriumMeasureNewton;


Begin["Private`"];
EquilibriumMeasureSupport[V_,retin_:{-1,1}]:=Module[{ret,retold,F,J,k},
F[{a_,b_}]:=Module[{Vf},
Vf=Fun[V,Line[{a,b}]];
{DCT[Vf'][[1]],(b-a)/8 DCT[Vf'][[2]]-1}];
J[{a_,b_}]:=Module[{Vf,x},
Vf=Fun[V,Line[{a,b}]];
x=IFun[Points[UnitInterval,Length[Vf]],Vf//Domain];
({
 {DCT[(1/2-x/2)Vf''][[1]], DCT[(1/2+x/2)Vf''][[1]]},
 {1/8 ((b-a)DCT[(1/2-x/2)Vf''][[2]]-DCT[Vf'][[2]]), 1/8 ((b-a)DCT[(1/2+x/2)Vf''][[2]]+DCT[Vf'][[2]])}
})
];
k=1;
ret=retin;
retold={0,0};
While[Norm[ret-retold]>$MachineTolerance,
k=k+1;
retold=ret;
ret=ret-LeastSquares[J[ret],F[ret]];
];
Sow[k];
ret//Sort];
EquilibriumMeasure[V_,retin_,x_]:=EquilibriumMeasure[V,retin][x];
EquilibriumMeasure[V_,retin_:{-1,1}]:=-1/(2 \[Pi]) SingFun[Fun[V',EquilibriumMeasureSupport[V,retin]//Line],{0,0}]//HilbertInverse;
PlotEquilibriumMeasure[V_,opts:OptionsPattern[]]:=Module[{supp,x,\[Psi]},
supp=EquilibriumMeasureSupport[V];
\[Psi][x_]=EquilibriumMeasure[V,supp,x];
Plot[\[Psi][x],{x,supp[[1]],supp[[2]]},opts]];


EquilibriumMeasureNewton[V_,lin_,m_]:=Module[{FJ,x,n},
FJ[fl_,ci_]:=Module[{HD,FD,a,b,i,j,spc,ciD,H},
b[j_]:=RightEndpoint[fl[[j]]];
a[j_]:=LeftEndpoint[fl[[j]]];
ciD[spc__]:=ciD[spc]=CauchyInverseCurvesD[spc][fl];

H[i_]:=CauchyInverseIntegralPlusSum[ci,b[i]]-V[b[i]]-(CauchyInverseIntegralPlusSum[ci,a[i+1]]-V[a[i+1]]);

HD[spc__][i_]:=CauchyInverseIntegralPlusEndpointD[spc][fl,2 i,ci,ciD[spc]]-(CauchyInverseIntegralPlusEndpointD[spc][fl,2 i+1,ci,ciD[spc]])+If[{spc}[[i]]=={0,1},
-V'[b[i]],0]-If[{spc}[[i+1]]=={1,0},
-V'[a[i+1]],0];
FD[spc__]:=Join[Mean/@ciD[spc],
{CauchyInverseSeriesAtInfinityD[spc][fl,ci,ciD[spc]]},
Table[HD[spc][j],{j,1,Length[fl]-1}]];
{Join[
	Mean/@ci,
{CauchyInverseSeriesAtInfinitySum[ci]-1},
Array[H,Length[fl]-1]],
(FD@@Partition[#,2])&/@IdentityMatrix[2 Length[fl]]//Transpose
}
];
x[0]=lin;
x[n_]:=x[n]=Module[{fl,ci,F,J},
fl=Fun[V',Line/@x[n-1],m OneVector[Length[x[n-1]]]];
ci=fl//CauchyInverseCurves;
{F,J}=FJ[fl,ci];
x[n-1]-Partition[Inverse[J].F,2]//Re];
x
];
EquilibriumMeasureSupport[V_,retin_?MatrixQ,m_]:=Module[{x,k},
x=EquilibriumMeasureNewton[V,retin,m];
k=1;
While[Norm[x[k]-x[k+1]]>$MachineTolerance,k++;];
x[k]
];
EquilibriumMeasure[V_,retin_?MatrixQ,m_]:=Module[{xn,fl,ci},
xn=EquilibriumMeasureSupport[V,retin,m];
fl=Fun[V',Line/@xn,m OneVector[Length[xn]]];
ci=fl//CauchyInverseCurves;
-1/(2 \[Pi])HilbertInverse[SingFun[#,{0,0}]]&/@ci
]



End[];
EndPackage[];
