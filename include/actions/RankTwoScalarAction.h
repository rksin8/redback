/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/*     REDBACK - Rock mEchanics with Dissipative feedBACKs      */
/*                                                              */
/*              (c) 2014 CSIRO and UNSW Australia               */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*            Prepared by CSIRO and UNSW Australia              */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#ifndef RANKTWOSCALARACTION_H
#define RANKTWOSCALARACTION_H

#include "Action.h"

class RankTwoScalarAction : public Action
{
public:
  RankTwoScalarAction(InputParameters params);

  MultiMooseEnum scalarOptions();
  virtual void act() override;
};

template <>
InputParameters validParams<RankTwoScalarAction>();

#endif // RANKTWOSCALARACTION_H
