/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/*     REDBACK - Rock mEchanics with Dissipative feedBACKs      */
/*                                                              */
/*                 (c) 2019 CSIRO                               */
/*               ALL RIGHTS RESERVED                            */
/*                                                              */
/*                Prepared by CSIRO                             */
/*                                                              */
/*        See COPYRIGHT for full restrictions                   */
/****************************************************************/
#ifndef DPGMYDGKERNEL21_H
#define DPGMYDGKERNEL21_H

#include "DGKernel.h"

// Forward Declarations
class DPGmyDGkernel21;

template <>
InputParameters validParams<DPGmyDGkernel21>();

class DPGmyDGkernel21 : public DGKernel
{
public:
  DPGmyDGkernel21(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual(Moose::DGResidualType type) override;
  virtual Real computeQpJacobian(Moose::DGJacobianType type) override;

private:
  const VariableValue & _kappa;
  const VariableValue & _kappa_neighbor;
};

#endif
