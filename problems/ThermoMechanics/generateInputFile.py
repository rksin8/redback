''' Script to generate redback input file from given user parameters '''

import os

def generateInputFile(input_filename, nb_points, coords_A=[], coords_B=[]):
    ''' Generate input file with multiple postprocessors to track temperature along a path A-B
        @param[in] input_filename - string, filename to create
        @param[in] nb_points - int, number of temperature points to track
        @param[in] coords_A - list of floats [x, y, z], coordinates of point A
        @param[in] coords_B - list of floats [x, y, z], coordinates of point B
    '''
    # Check input parameters
    if not type(nb_points) == int and nb_points < 0:
        raise Exception, '"nb_points" must be an integer >= 0'
    if nb_points > 0:
        if not type(coords_A) == list and len(coords_A) == 3:
            raise Exception, '"coords_A" must be a list of 3 elements (x,y,z coordinates for point A)'
        if not type(coords_B) == list and len(coords_B) == 3:
            raise Exception, '"coords_B" must be a list of 3 elements (x,y,z coordinates for point B)'
    
    # Generate postprocessor info based on input parameters
    names = ['Gruntfest_number','mises_stress','strain_rate'] # names of postprocessors to create in moose input file
    pp_txt_gr = \
        "  [./Gruntfest_number]\n"\
        "    type = PointValue\n"\
        "    variable = Mod_Gruntfest_number\n"\
        "    point = '0.5 0.5 0'\n"\
        "  [../]\n"
    pp_txt_mises_stress = \
        "  [./mises_stress]\n"\
        "    type = PointValue\n"\
        "    variable = mises_stress\n"\
        "    point = '0.5 0.5 0'\n"\
        "  [../]\n"
    pp_txt_strain_rate = \
        "  [./strain_rate]\n"\
        "    type = PointValue\n"\
        "    variable = mises_strain_rate\n"\
        "    point = '0.5 0.5 0'\n"\
        "  [../]\n"
    pp_texts = [pp_txt_gr, pp_txt_mises_stress, pp_txt_strain_rate] # text block defining all postprocessors
    if nb_points == 0:
        pass
    elif nb_points == 1:
        # Pick the middle of segment A-B
        name = 'temp_midAB'
        names.append(name)
        pp_text = \
            "  [./{name}]\n"\
            "    type = PointValue\n"\
            "    variable = temp\n"\
            "    point = '{x} {y} {z}'\n"\
            "  [../]\n".format(name=name,
                               x=(coords_A[0]+coords_B[0])/2.,
                               y=(coords_A[1]+coords_B[1])/2.,
                               z=(coords_A[2]+coords_B[2])/2.)
        pp_texts.append(pp_text)
    else:
        assert nb_points>1 # Was checked ahead already...
        
        for i in range(nb_points):
            name = 'temp_{0}'.format(i) # postprocessor name
            names.append(name)
            # Find coordinates for that point on A-B segment
            pp_text = \
                "  [./{name}]\n"\
                "    type = PointValue\n"\
                "    variable = temp\n"\
                "    point = '{x} {y} {z}'\n"\
                "  [../]\n".format(name=name,
                                   x=coords_A[0]+i*(coords_B[0]-coords_A[0])/float(nb_points-1),
                                   y=coords_A[1]+i*(coords_B[1]-coords_A[1])/float(nb_points-1),
                                   z=coords_A[2]+i*(coords_B[2]-coords_A[2])/float(nb_points-1))
            pp_texts.append(pp_text)
    
    active_pps = ' '.join(names)
    pp_final_text = ''.join(pp_texts)
    
    # Create content for .i input file
    content = '''# Note: This input file was generated by "generateInputFile.py"
# so edit the python script rather than this file...

[Mesh]
  type = FileMesh
  file = 2d_square_400elements_2corners_inclusion.msh
[]

[MeshModifiers]
  [./left_mid_point]
    type = AddExtraNodeset
    boundary = 4
    coord = '0.0 0.5'
  [../]
  [./right_mid_point]
    type = AddExtraNodeset
    boundary = 5
    coord = '1 0.5'
  [../]
  [./top_mid_point]
    type = AddExtraNodeset
    boundary = 6
    coord = '0.5 1'
  [../]
  [./bottom_mid_point]
    type = AddExtraNodeset
    boundary = 7
    coord = '0.5 0'
  [../]
[]

[Variables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temp]
  [../]
[]

[TensorMechanics]
  [./solid]
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    temp = temp
  [../]
[]

[Materials]
  [./mat0]
    type = RedbackMaterial
    block = '0 1'
    disp_y = disp_y
    disp_x = disp_x
    C_ijkl = '1.346e+03 5.769e+02 5.769e+02 1.346e+03 5.769e+02 1.346e+03 3.846e+02 3.846e+02 3.846e+2'
    temperature = temp
    yield_stress = '0. 1 1. 1'
    disp_z = disp_z
    ar_c = 1
    m = 2
    da = 1
    mu = 1
    ar = 5
    gr = 0.2
    pore_pres = 0
    is_mechanics_on = true
  [../]
[]

[Functions]
  active = 'spline_IC downfunc'
  [./upfunc]
    type = ParsedFunction
    value = t
  [../]
  [./downfunc]
    type = ParsedFunction
    value = -1e-4*t
  [../]
  [./spline_IC]
    type = ConstantFunction
    value = 1
  [../]
[]

[BCs]
  active = 'right_disp temp_mid_pts left_disp rigth_disp_y left_disp_y'
  [./left_disp]
    type = DirichletBC
    variable = disp_x
    boundary = 3
    value = 0
  [../]
  [./right_disp]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 1
    function = downfunc
  [../]
  [./bottom_temp]
    type = NeumannBC
    variable = temp
    boundary = 0
    value = -1
  [../]
  [./top_temp]
    type = NeumannBC
    variable = temp
    boundary = 2
    value = -1
  [../]
  [./left_disp_y]
    type = DirichletBC
    variable = disp_y
    boundary = 3
    value = 0
  [../]
  [./temp_mid_pts]
    type = DirichletBC
    variable = temp
    boundary = '4 5 6 7'
    value = 0
  [../]
  [./rigth_disp_y]
    type = DirichletBC
    variable = disp_y
    boundary = 1
    value = 0
  [../]
  [./temp_box]
    type = DirichletBC
    variable = temp
    boundary = '0 1 2 3'
    value = 0
  [../]
  [./constant_force_right]
    type = NeumannBC
    variable = disp_x
    boundary = 1
    value = -2
  [../]
[]

[AuxVariables]
  active = 'Mod_Gruntfest_number mises_strain mech_diss mises_strain_rate mises_stress'
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./peeq]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pe11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pe22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pe33]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mises_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mises_strain]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mises_strain_rate]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mech_diss]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./Mod_Gruntfest_number]
    order = CONSTANT
    family = MONOMIAL
    block = '0 1'
  [../]
[]

[Kernels]
  [./temp_td]
    type = TimeDerivative
    variable = temp
    block = '0 1'
  [../]
  [./temp_diff]
    type = AnisotropicDiffusion
    variable = temp
    block = '0 1'
    tensor_coeff = '1 0 0 0 1 0 0 0 1'
  [../]
  [./temp_dissip]
    type = RedbackMechDissip
    variable = temp
    block = '0 1'
  [../]
[]

[AuxKernels]
  active = 'mises_strain mises_strain_rate mises_stress mech_dissipation Gruntfest_Number'
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./pe11]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe11
    index_i = 0
    index_j = 0
  [../]
  [./pe22]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe22
    index_i = 1
    index_j = 1
  [../]
  [./pe33]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe33
    index_i = 2
    index_j = 2
  [../]
  [./eqv_plastic_strain]
    type = FiniteStrainPlasticAux
    variable = peeq
  [../]
  [./mises_stress]
    type = MaterialRealAux
    variable = mises_stress
    property = mises_stress
  [../]
  [./mises_strain]
    type = MaterialRealAux
    variable = mises_strain
    property = mises_strain
  [../]
  [./mises_strain_rate]
    type = MaterialRealAux
    variable = mises_strain_rate
    block = 0
    property = mises_strain_rate
  [../]
  [./mech_dissipation]
    type = MaterialRealAux
    variable = mech_diss
    property = mechanical_dissipation
  [../]
  [./Gruntfest_Number]
    type = MaterialRealAux
    variable = Mod_Gruntfest_number
    property = mod_gruntfest_number
    block = '0 1'
  [../]
[]

[Postprocessors]
  active = '{active_post_procs}'
  {post_proc_blocks}
[]

[Preconditioning]
  # active = ''
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  start_time = 0.0
  end_time = 100
  dtmax = 1
  dtmin = 1e-7
  type = Transient
  l_max_its = 200
  nl_max_its = 10
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type -snes_linesearch_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg cp 201'
  nl_abs_tol = 1e-10 # 1e-10 to begin with
  reset_dt = true
  line_search = basic
  [./TimeStepper]
    type = SolutionTimeAdaptiveDT
    dt = 1e-3
  [../]
[]

[Outputs]
  file_base = out
  output_initial = true
  exodus = true
  [./console]
    type = Console
    perf_log = true
    linear_residuals = true
  [../]
[]

[ICs]
  active = 'ic_temp'
  [./ic_temp]
    variable = temp
    value = 0
    type = ConstantIC
    block = '0 1'
  [../]
  [./Spline_IC]
    function = spline_IC
    variable = temp
    type = FunctionIC
    block = 0
  [../]
[]
'''.format(active_post_procs=active_pps, post_proc_blocks=pp_final_text.strip())
    
    # Write content to file
    with open(input_filename, 'w') as f:
        f.write(content)
        print 'File "{0}" created'.format(os.path.realpath(input_filename))
    return


if __name__ == '__main__':
    generateInputFile('heatlines_velocityDependence_pp.i', nb_points=11, coords_A=[0.8, 0.1, 0], coords_B=[0.9, 0.2, 0])
    print 'Finished'