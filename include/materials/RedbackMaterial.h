/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#ifndef REDBACKMATERIAL_H
#define REDBACKMATERIAL_H

//#include "FiniteStrainPlasticMaterial.h"
#include "Material.h"


//Forward Declarations
class RedbackMaterial;

template<>
InputParameters validParams<RedbackMaterial>();

class RedbackMaterial : public Material
{
public:
  RedbackMaterial(const std::string & name, InputParameters parameters);

  /// Static method for use in validParams for getting the density method
  static MooseEnum densityMethodEnum();

  // various methods to handle density (variation with T and P)
  enum DensityMethod
  {
    linear
  };

  /// Static method for use in validParams for getting the permeability method
  static MooseEnum permeabilityMethodEnum();

  // various methods to handle permeability evolution
  enum PermeabilityMethod
  {
    KozenyCarman
  };

protected:
  virtual void computeQpProperties();
  virtual void initQpStatefulProperties();
  virtual void computeRedbackTerms();

  bool _has_T;
  VariableValue & _T;
  bool _has_pore_pres;
  VariableValue & _pore_pres;
  
  Real _phi0_param, _gr_param, _ref_lewis_nb_param, _ar_param, _delta_param, _m_param, _exponent, _peclet_number; //_ar_c_param, _da_param, _mu_param,
  Real  _ar_F_param, _ar_R_param, _da_endo_param, _da_exo_param, _mu_param, _Kc_param, _eta1_param, _eta2_param, _Aphi_param, _pressurization_coefficient_param;
  Real _solid_compressibility_param, _fluid_compressibility_param, _solid_thermal_expansion_param, _fluid_thermal_expansion_param, _solid_density_param, _fluid_density_param;
  bool _is_chemistry_on, _are_convective_terms_on;

  RealVectorValue _gravity_param;

  MaterialProperty<RealVectorValue> & _mixture_gravity_term;
  MaterialProperty<RealVectorValue> & _fluid_gravity_term;

  MaterialProperty<Real> & _useless_property_old; //TODO: this is a useless quantity, just to call initQpStatefulProperties without mechanics. find a better way to initialize
  MaterialProperty<Real> & _gr;
  MaterialProperty<Real> & _ref_lewis_nb;
  MaterialProperty<Real> & _ar;
  MaterialProperty<Real> & _delta;
  MaterialProperty<Real> & _m;
  
  MaterialProperty<Real> & _porosity;
  MaterialProperty<Real> & _lewis_number;

  MaterialProperty<Real> & _mod_gruntfest_number;
  MaterialProperty<Real> & _mechanical_dissipation;
  MaterialProperty<Real> & _mechanical_dissipation_jac;
  
  MaterialProperty<Real> & _ar_F;
  MaterialProperty<Real> & _ar_R;
  MaterialProperty<Real> & _mu;

  MaterialProperty<Real> & _chemical_porosity;
  MaterialProperty<Real> & _solid_ratio;
  MaterialProperty<Real> & _chemical_endothermic_energy;
  MaterialProperty<Real> & _chemical_endothermic_energy_jac;
  MaterialProperty<Real> & _chemical_exothermic_energy;
  MaterialProperty<Real> & _chemical_exothermic_energy_jac;
  MaterialProperty<Real> & _chemical_source_mass;
  MaterialProperty<Real> & _chemical_source_mass_jac;

  MaterialProperty<RealVectorValue> & _thermal_convective_mass;
  MaterialProperty<RealVectorValue> & _thermal_convective_mass_jac;
  MaterialProperty<RealVectorValue> & _pressure_convective_mass;
  MaterialProperty<RealVectorValue> & _pressure_convective_mass_jac;
  MaterialProperty<RealVectorValue> & _mixture_convective_energy;
  MaterialProperty<RealVectorValue> & _mixture_convective_energy_jac;

  MaterialProperty<RealVectorValue> & _solid_velocity;
  MaterialProperty<RealVectorValue> & _fluid_velocity;
  MaterialProperty<Real> & _solid_compressibility; // \bar(\beta_s)/\sigma_{ref}
  MaterialProperty<Real> & _fluid_compressibility; // \bar(\beta_f)/\sigma_{ref}
  MaterialProperty<Real> & _solid_thermal_expansion; // \bar(\lambda_s)/ \delta T_ref
  MaterialProperty<Real> & _fluid_thermal_expansion; // \bar(\lambda_f)/delta T_ref

  MaterialProperty<Real> & _mixture_density;

  RedbackMaterial::DensityMethod _density_method;
  RedbackMaterial::PermeabilityMethod _permeability_method; // TODO: remove RedbackMaterial???

  Real _exponential;

  MaterialProperty<Real> & _mises_strain;
  MaterialProperty<Real> & _mises_strain_rate;

  MaterialProperty<Real> & _pressurization_coefficient;

  VariableGradient& _grad_pore_pressure;

};

#endif //REDBACKMATERIAL_H