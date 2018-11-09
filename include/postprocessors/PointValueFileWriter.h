//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef POINTVALUEFILEWRITER_H
#define POINTVALUEFILEWRITER_H

#include "GeneralPostprocessor.h"

// Forward Declarations
class PointValueFileWriter;

template <>
InputParameters validParams<PointValueFileWriter>();

/**
 * Compute the value of a variable at a specified location.
 *
 * Warning: This postprocessor may result in undefined behavior if utilized with
 * non-continuous elements and the point being located lies on an element boundary.
 */
class PointValueFileWriter : public GeneralPostprocessor
{
public:
  PointValueFileWriter(const InputParameters & parameters);

  virtual void initialize() override {}
  virtual void execute() override;
  virtual void finalize() override {}
  virtual Real getValue() override;

protected:
  /// The variable number of the variable we are operating on
  const unsigned int _var_number;

  /// A reference to the system containing the variable
  const System & _system;

  /// The point to locate
  const Point & _point;

  /// The value of the variable at the desired location
  Real _poro_value;
  Real _old_poro_value;

  FileName _file_name;
  FileName _working_file_name;
  FileName _multiapp_file_name;
  std::string _value_pore;
  std::string _value_grain;
  unsigned int _refinement;
  int _size_x;
  int _size_y;
  int _size_z;
  std::string _neighbours;
  Real _pore_volume;
  Real _upper_layer_bound;
  Real _lower_layer_bound;
  std::string _data_x_axis_text;
  std::string _data_y_axis_text;
  std::string _data_z_axis_text;
  std::vector<std::pair<int, int>> _boundary_elements;
  std::string _boundary_element_value;
  std::vector<std::vector<std::string>> _data;

  void FileWriter();
  void BoundaryElements();
  bool CheckBoundary(int z, int y, int x);
  void PushBoundaryElement(int z, int y, int x);
};

#endif /* POINTVALUEFILEWRITER_H */