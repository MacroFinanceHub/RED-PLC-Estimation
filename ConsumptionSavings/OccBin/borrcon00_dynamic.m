function [residual, g1, g2, g3] = borrcon00_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(7, 1);
T27 = y(5)^params(6);
T31 = y(10)^params(6);
lhs =y(6);
rhs =y(10);
residual(1)= lhs-rhs;
lhs =y(5);
rhs =y(9)+y(3)-params(4)*y(1);
residual(2)= lhs-rhs;
lhs =y(3);
rhs =y(9)*params(3);
residual(3)= lhs-rhs;
lhs =y(4);
rhs =y(9)*params(3);
residual(4)= lhs-rhs;
lhs =y(7);
rhs =1/T27-params(4)*params(2)/T31;
residual(5)= lhs-rhs;
lhs =log(y(9));
rhs =params(1)*log(y(2))+x(it_, 1);
residual(6)= lhs-rhs;
lhs =y(8);
rhs =y(3)-y(4);
residual(7)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(7, 11);

  %
  % Jacobian matrix
  %

  g1(1,10)=(-1);
  g1(1,6)=1;
  g1(2,1)=params(4);
  g1(2,3)=(-1);
  g1(2,5)=1;
  g1(2,9)=(-1);
  g1(3,3)=1;
  g1(3,9)=(-params(3));
  g1(4,4)=1;
  g1(4,9)=(-params(3));
  g1(5,5)=(-((-(getPowerDeriv(y(5),params(6),1)))/(T27*T27)));
  g1(5,10)=(-(params(4)*params(2)*getPowerDeriv(y(10),params(6),1)))/(T31*T31);
  g1(5,7)=1;
  g1(6,2)=(-(params(1)*1/y(2)));
  g1(6,9)=1/y(9);
  g1(6,11)=(-1);
  g1(7,3)=(-1);
  g1(7,4)=1;
  g1(7,8)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],7,121);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],7,1331);
end
end
end
end