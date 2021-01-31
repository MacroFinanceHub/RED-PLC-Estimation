% [zdatalinear zdatapiecewise zdatass oo 00 M 00] = solve two constraints(modnam 00,modnam 10,modnam 01,modnam 11,... constraint1, constraint2,... constraint relax1, constraint relax2,... shockssequence,irfshock,nperiods,curb retrench,maxiter,init);
% 
% Inputs:
% modnam 00: name of the .mod file for reference regime (excludes the .mod extension). modnam10: name of the .mod file for the alternative regime governed by the first
% constraint.
% modnam01: name of the .mod file for the alternative regime governed by the second constraint.
% modnam 11: name of the .mod file for the case in which both constraints force a switch to their alternative regimes.


% Log of changes
% 6/17/2013 -- Luca added a trailing underscore to local variables in an
% attempt to avoid conflicts with parameter names defined in the .mod files
% to be processed.
% 6/17/2013 -- Luca replaced external .m file setss.m

function solve_one_constraints_firstcall(modnam_00_,modnam_10_)

global M_ oo_

global oo00_  M00_ M10_  

global cof cof10 cof01 cof11 ...
       Jbarmat Jbarmat10  ...
       Dbarmat10 ...
       decrulea decruleb


% solve model
eval(['dynare ',modnam_00_,' noclearall nolog'])
oo00_ = oo_;
M00_ = M_;


eval(['dynare ',modnam_10_,' noclearall nolog'])
oo10_ = oo_;
M10_ = M_;



% do some error checking

% check inputs
% if ~strcmp(M00_.endo_names,M10_.endo_names)
%     error([modnam_00_,' and ',modnam_10_,' need to have exactly the same endogenous variables and they need to be declared in the same order'])
% end
% 
% if ~strcmp(M00_.exo_names,M10_.exo_names)
%     error([modnam_00_,' and ',modnam_10_,' need to have exactly the same exogenous variables and they need to be declared in the same order'])
% end
% 
% if ~strcmp(M00_.param_names,M10_.param_names)
%     warning(['The parameter list does not match across the files ',modnam_00_,' and ',modnam_10_])
% end
% 
% 
% if ~strcmp(M00_.endo_names,M01_.endo_names)
%     error([modnam_00,' and ',modnam_01_,' need to have exactly the same endogenous variables and they need to be declared in the same order'])
% end
% 
% if ~strcmp(M00_.exo_names,M01_.exo_names)
%     error([modnam_00_,' and ',modnam_01_,' need to have exactly the same exogenous variables and they need to be declared in the same order'])
% end
% 
% if ~strcmp(M00_.param_names,M01_.param_names)
%     warning(['The parameter list does not match across the files ',modnam_00_,' and ',modnam_01_])
% end
% 
% 
% if ~strcmp(M00_.endo_names,M11_.endo_names)
%     error([modnam_00_,' and ',modnam_11_,' need to have exactly the same endogenous variables and they need to be declared in the same order'])
% end
% 
% if ~strcmp(M00_.exo_names,M11_.exo_names)
%     error([modnam_00_,' and ',modnam_11_,' need to have exactly the same exogenous variables and they need to be declared in the same order'])
% end
% 
% if ~strcmp(M00_.param_names,M11_.param_names)
%     warning(['The parameter list does not match across the files ',modnam_00_,' and ',modnam_11_])
% end


zdatass = oo00_.dr.ys;

[hm1,h,hl1,Jbarmat] = get_deriv(M00_,zdatass);
cof = [hm1,h,hl1];


M10_.params = M00_.params;
[hm1,h,hl1,Jbarmat10,resid] = get_deriv(M10_,zdatass);
cof10 = [hm1,h,hl1];
Dbarmat10 = resid;


% ADDED FOR COMPATIBILITY WITH DYNARE 4.5> and ABOVE
oo00_.dr.nstatic = M00_.nstatic;
oo00_.dr.nfwrd = M00_.nfwrd;

% MAtteo: this code could be buggy
[decrulea,decruleb]=get_pq(oo00_.dr);


% if isfield(M00_,'nfwrd')
%     % the latest Dynare distributions have moved nstatic and nfwrd
%     [decrulea,decruleb]=get_pq(oo00_.dr,M00_.nstatic,M00_.nfwrd);
% else
%     [decrulea,decruleb]=get_pq(oo00_.dr,oo00_.dr.nstatic,oo00_.dr.nfwrd);
% end
% 









