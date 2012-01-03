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


OrthogonalPolynomialGenerator;


Begin["Private`"];


GFunction[V_,z_]:=Module[{supp},
supp=EquilibriumMeasureSupport[V];
CauchyInverseIntegral[Fun[V',Line[supp]],z]];
GFunction[s_?SignQ,V_,z_]:=Module[{supp},
supp=EquilibriumMeasureSupport[V];
CauchyInverseIntegralS[s,Fun[V',Line[supp]],z]];

LeftOfLine[z_,Line[{a_,b_}]]:=(Im[a]-Im[b])/(Re[a]-Re[b]) Re[z] +(Im[b] Re[a] -Im[a] Re[b])/(Re[a]-Re[b])<Im[z];
RightOfLine[z_,Line[{a_,b_}]]:=(Im[a]-Im[b])/(Re[a]-Re[b]) Re[z] +(Im[b] Re[a] -Im[a] Re[b])/(Re[a]-Re[b])>Im[z];


OrthogonalPolynomialMatrixGenerator[V_,M_:40,L_:5.]:=Module[{supp,g,l,z,\[Phi],P,Pin,rngg,Cdefs,a,b,A,B,AP,BP,gs,m,U,\[CapitalPsi],\[CapitalPhi],p,slvr,Y,UD,\[CapitalPsi]D,\[Phi]D,\[CapitalPhi]D,YD,PD,BD,BinD},
supp=Line[{a,b}=EquilibriumMeasureSupport[V]];
g[z_]=GFunction[V,z];
g[+1,z_]=GFunction[+1,V,z];
g[-1,z_]=GFunction[-1,V,z];
l=-(g[+1,0.]+g[-1,0.]-V[0.]);



\[Phi][z_]=(V[z]-l)/2-g[z];
\[Phi]D[z_]=(V'[z])/2-g'[z];
\[Phi][+1,z_]=-(g[+1,z]-(V[z]-l)/2);
\[Phi][-1,z_]=-(g[-1,z]-(V[z]-l)/2);

P[z_]=Parametrix[({
 {0, 1},
 {-1, 0}
}),supp,z];
PD[z_]=P'[z];
P[-1,z_]=ParametrixBranch[({
 {0, 1},
 {-1, 0}
}),supp,z,-2 \[Pi]];
Pin[z_]=Inverse[P[z]];
Pin[-1,z_]=Inverse[P[-1,z]];


rngg={.5,L};
Cdefs[m_]:={Function[n,({
 {b, a},
 {n^(2/3), -n^(2/3)}
})],({
 {Line[rngg], m},
 {Line[Exp[2 \[Pi] I/3]Reverse[rngg]], m},
 {Line[Exp[-2I \[Pi]/3]Reverse[rngg]], m},
 {Line[{Exp[2 I \[Pi]/3] ,1 }rngg[[1]]], m},
 {Line[{1 ,Exp[ -2 I \[Pi]/3] }rngg[[1]]], m},
 {Line[{Exp[ -2 I \[Pi]/3] ,Exp[ -4 I \[Pi]/3] }rngg[[1]]], m}
})};

A[n_][z_]:=({
 {1, Exp[-2 n \[Phi][z]]},
 {0, 1}
});
B[n_][z_]:=({
 {1, 0},
 {Exp[2 n \[Phi][z]], 1}
});
AP[n_][z_]:=P[z].A[n][z].Pin[z];
BP[n_][z_]:=P[z].B[n][z].Pin[z];


BD[n_][z_]:=({
 {0, 0},
 {2 n \[Phi]D[z]Exp[2 n \[Phi][z]], 0}
});
BinD[n_][z_]:=({
 {0, 0},
 {-2 n \[Phi]D[z]Exp[2 n \[Phi][z]], 0}
});



gs[n_]:=({
 {AP[n], Inverse[AP[n][#]]&},
 {BP[n], Inverse[BP[n][#]]&},
 {BP[n], Inverse[BP[n][#]]&},
 {({
   {Exp[n \[Phi][#]], 0},
   {0, Exp[-n \[Phi][#]]}
  }).Pin[#]&, ({
   {1, -1},
   {1, 0}
  }).({
   {Exp[n \[Phi][#]], 0},
   {0, Exp[-n \[Phi][#]]}
  }).Pin[#]&},
 {({
   {1, -1},
   {0, 1}
  }).({
   {Exp[n \[Phi][#]], 0},
   {0, Exp[-n \[Phi][#]]}
  }).Pin[#]&, ({
   {1, 0},
   {1, 1}
  }).({
   {Exp[n \[Phi][#]], 0},
   {0, Exp[-n \[Phi][#]]}
  }).Pin[#]&},
 {({
   {0, -1},
   {1, 1}
  }).({
   {Exp[n \[Phi][-1,#]], 0},
   {0, Exp[-n \[Phi][-1,#]]}
  }).Pin[-1,#]&, ({
   {0, -1},
   {1, 0}
  }).({
   {Exp[n \[Phi][-1,#]], 0},
   {0, Exp[-n \[Phi][-1,#]]}
  }).Pin[-1,#]&}
});

slvr=ScaledRHSolver[Cdefs[M]];

U[n_]:=U[n]=slvr[n,gs[n]];
U[n_,z_]:=Dot@@(IdentityMatrix[2]+Cauchy[#,z]&/@U[n]);


\[CapitalPsi][n_,z_]/;RightOfLine[z-b,Line[{Exp[2 I \[Pi]/3] ,1 }rngg[[1]]/n^(2/3)]] &&0<=Arg[z-b]<2 \[Pi]/3:=U[n,z].({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;Re[z]>b+Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ]&&2 \[Pi]/3<Arg[z-b]<=\[Pi]:=U[n,z].({
 {1, 0},
 {-1, 1}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;Re[z]>b+Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&-\[Pi]<Arg[z-b]<-2\[Pi]/3:=U[n,z].({
 {0, -1},
 {1, 1}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;RightOfLine[z-b,Line[{1,Exp[-2 I \[Pi]/3] }rngg[[1]]/n^(2/3)]] &&-2\[Pi]/3<Arg[z-b]<0:=U[n,z].({
 {1, -1},
 {0, 1}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;Re[z]<a-Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&0<=Arg[z-a]< \[Pi]/3:=U[n,z].({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;LeftOfLine[a-z,Line[{1,Exp[-2 I \[Pi]/3] }rngg[[1]]/n^(2/3)]] && \[Pi]/3<Arg[z-a]<=\[Pi]:=U[n,z].({
 {1, 0},
 {1, 1}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;LeftOfLine[a-z,Line[{Exp[2 I \[Pi]/3] ,1 }rngg[[1]]/n^(2/3)]] &&-\[Pi]<Arg[z-a]<-\[Pi]/3:=U[n,z].({
 {1, -1},
 {1, 0}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]/;Re[z]<a-Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&-\[Pi]/3<Arg[z-a]<0:=U[n,z].({
 {0, -1},
 {1, 0}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
});
\[CapitalPsi][n_,z_]:=U[n,z].P[z];


\[CapitalPhi][n_,z_]/;Im[z]>=0&&2\[Pi]/3<Arg[z-b]&&0<=Arg[z-a]<\[Pi]/3:=\[CapitalPsi][n,z].B[n][z];
\[CapitalPhi][n_,z_]/;Im[z]<0&&Arg[z-b]<-2\[Pi]/3&&-\[Pi]/3<Arg[z-a]<0:=\[CapitalPsi][n,z].Inverse[B[n][z]];
\[CapitalPhi][n_,z_]:=\[CapitalPsi][n,z];
    Y[n_,z_]:=Y[n,z]=({
 {Exp[-n l/2], 0},
 {0, Exp[n l/2]}
}).\[CapitalPhi][n,z].({
 {Exp[n l/2], 0},
 {0, Exp[-n l/2]}
}).({
 {Exp[n g[z]], 0},
 {0, Exp[-n g[z]]}
});



UD[n_,z_]:=(IdentityMatrix[2]+Cauchy[U[n][[1]],z]).CauchyD[U[n][[2]],z]+CauchyD[U[n][[1]],z].(IdentityMatrix[2]+Cauchy[U[n][[2]],z]);
\[CapitalPsi]D[n_,z_]/;RightOfLine[z-b,Line[{Exp[2 I \[Pi]/3] ,1 }rngg[[1]]/n^(2/3)]] &&0<=Arg[z-b]<2 \[Pi]/3:=UD[n,z].({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;Re[z]>b+Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&2 \[Pi]/3<Arg[z-b]<=\[Pi]:=UD[n,z].({
 {1, 0},
 {-1, 1}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {1, 0},
 {-1, 1}
}).({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;Re[z]>b+Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&-\[Pi]<Arg[z-b]<-2\[Pi]/3:=UD[n,z].({
 {0, -1},
 {1, 1}
}) .({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {0, -1},
 {1, 1}
}) .({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;RightOfLine[z-b,Line[{1,Exp[-2 I \[Pi]/3] }rngg[[1]]/n^(2/3)]] &&-2\[Pi]/3<Arg[z-b]<0:=UD[n,z].({
 {1, -1},
 {0, 1}
}) .({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {1, -1},
 {0, 1}
}) .({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;Re[z]<a-Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&0<=Arg[z-a]< \[Pi]/3:=UD[n,z].({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;LeftOfLine[a-z,Line[{1,Exp[-2 I \[Pi]/3] }rngg[[1]]/n^(2/3)]] && \[Pi]/3<Arg[z-a]<=\[Pi]:=UD[n,z].({
 {1, 0},
 {1, 1}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {1, 0},
 {1, 1}
}).({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;LeftOfLine[a-z,Line[{Exp[2 I \[Pi]/3] ,1 }rngg[[1]]/n^(2/3)]] &&-\[Pi]<Arg[z-a]<-\[Pi]/3:=UD[n,z].({
 {1, -1},
 {1, 0}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {1, -1},
 {1, 0}
}).({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]/;Re[z]<a-Re[rngg[[1]] Exp[2 I \[Pi]/3]/n^(2/3) ] &&-\[Pi]/3<Arg[z-a]<0:=UD[n,z].({
 {0, -1},
 {1, 0}
}).({
 {Exp[n \[Phi][z]], 0},
 {0, Exp[-n \[Phi][z]]}
})+\[Phi]D[z] U[n,z].({
 {0, -1},
 {1, 0}
}).({
 {n Exp[n \[Phi][z]], 0},
 {0, -n Exp[-n \[Phi][z]]}
});
\[CapitalPsi]D[n_,z_]:=UD[n,z].P[z]+U[n,z].PD[z];
\[CapitalPhi]D[n_,z_]/;Im[z]>=0&&2\[Pi]/3<Arg[z-b]&&0<=Arg[z-a]<\[Pi]/3:=\[CapitalPsi]D[n,z].B[n][z]+\[CapitalPsi][n,z].BD[n][z];
\[CapitalPhi]D[n_,z_]/;Im[z]<0&&Arg[z-b]<-2\[Pi]/3&&-\[Pi]/3<Arg[z-a]<0:=\[CapitalPsi]D[n,z].Inverse[B[n][z]]+\[CapitalPsi][n,z].BinD[n][z];
\[CapitalPhi]D[n_,z_]:=\[CapitalPsi]D[n,z];
YD[n_,z_]:=YD[n,z]=({
 {Exp[-n l/2], 0},
 {0, Exp[n l/2]}
}).\[CapitalPhi]D[n,z].({
 {Exp[n l/2], 0},
 {0, Exp[-n l/2]}
}).({
 {Exp[n g[z]], 0},
 {0, Exp[-n g[z]]}
})+n g'[z] ({
 {Exp[-n l/2], 0},
 {0, Exp[n l/2]}
}).\[CapitalPhi][n,z].({
 {Exp[n l/2], 0},
 {0, Exp[-n l/2]}
}).({
 {Exp[n g[z]], 0},
 {0, -Exp[-n g[z]]}
});

{Y,YD}

];
OrthogonalPolynomialGenerator[V_,M_:40,L_:5.]:=
Module[{Y,p},
Y=OrthogonalPolynomialMatrixGenerator[V,M,L][[1]];
p[n_,z_]:=Y[n,z][[1,1]];
p]


End[];
EndPackage[];
