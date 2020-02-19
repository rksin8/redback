[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 1
  ny = 10
  xmin = 0
  xmax = 60
  ymin = 0
  zmax = 60
  ymax = 60
[]

[Variables]
  inactive = 'temp'
  [disp_x]
    order = FIRST
    family = LAGRANGE
  []
  [disp_y]
    order = FIRST
    family = LAGRANGE
  []
  [disp_z]
    order = FIRST
    family = LAGRANGE
  []
  [temp]
  []
[]

[Materials]
  [mat_mech0]
    # yield_criterion = Drucker_Prager
    # fill_method = symmetric_isotropic
    # C_ijkl = '576.923076923 384.615384615' # young = 1000, poisson = 0.3
    block = 0
    type = RedbackMechMaterialDP
    disp_x = 'disp_x'
    disp_y = 'disp_y'
    disp_z = 'disp_z'
    exponent = 1
    C_ijkl = '1.3333E3 4.0E3 0.0'
    fill_method = general_isotropic
    ref_pe_rate = 1
    slope_yield_surface = 0
    yield_stress = '0. 100 0.1 10'
    total_porosity = 'total_porosity'
  []
  [mat_mech1]
    # yield_criterion = Drucker_Prager
    # fill_method = symmetric_isotropic
    # C_ijkl = '576.923076923 384.615384615' # young = 1000, poisson = 0.3
    block = 1
    type = RedbackMechMaterialDP
    disp_x = 'disp_x'
    disp_y = 'disp_y'
    disp_z = 'disp_z'
    exponent = 1
    C_ijkl = '1.3333E3 4.0E3 0.0'
    fill_method = general_isotropic
    ref_pe_rate = 1
    slope_yield_surface = 0
    yield_stress = '0. 99 0.1 9'
    total_porosity = 'total_porosity'
  []

  [mat_nomech]
    type = RedbackMaterial
    disp_x = 'disp_x'
    disp_y = 'disp_y'
    disp_z = 'disp_z'
    is_mechanics_on = false
    Aphi = 0
    ar = 0
    ar_F = 1
    ar_R = 1
    gr = 0.1
    alpha_2 = 1
    phi0 = 0.1
    ref_lewis_nb = 1
    total_porosity = 'total_porosity'
  []
[]

[Functions]
  inactive = 'upfunc spline_IC'
  [upfunc]
    type = ParsedFunction
    value = 't'
  []
  [spline_IC]
    type = ConstantFunction
  []
  [ramp]
    type = ParsedFunction
    value = '0.1*t'
  []
[]

[BCs]
  [uy_bottom]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom'
    value = 0
  []
  [uz_bottom]
    type = DirichletBC
    variable = disp_z
    boundary = 'bottom'
    value = 0.0
  []
  [ux_zero_bottom]
    type = DirichletBC
    variable = disp_x
    boundary = 'bottom'
    function = '0.0'
    value = 0
  []
  [Periodic]
    [x_direction]
      variable = 'disp_x disp_y disp_z'
      auto_direction = 'x'
    []
    [z_direction]
      variable = 'disp_x disp_y disp_z'
      auto_direction = 'z'
    []
  []
  [ux_ramp_top]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = 'top'
    function = ramp
  []
[]

[AuxVariables]
  inactive = 'peeq'
  [stress_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [peeq]
    order = CONSTANT
    family = MONOMIAL
  []
  [pe11]
    order = CONSTANT
    family = MONOMIAL
  []
  [pe22]
    order = CONSTANT
    family = MONOMIAL
  []
  [pe33]
    order = CONSTANT
    family = MONOMIAL
  []
  [mises_stress]
    order = CONSTANT
    family = MONOMIAL
  []
  [mises_strain]
    order = CONSTANT
    family = MONOMIAL
  []
  [mises_strain_rate]
    order = CONSTANT
    family = MONOMIAL
    block = '0'
  []
  [Mod_Gruntfest_number]
    order = CONSTANT
    family = MONOMIAL
  []
  [volumetric_strain]
    order = CONSTANT
    family = MONOMIAL
  []
  [volumetric_strain_rate]
    order = CONSTANT
    family = MONOMIAL
  []
  [mean_stress]
    order = CONSTANT
    family = MONOMIAL
    block = '0'
  []
  [total_porosity]
    order = FIRST
    family = MONOMIAL
  []
  [mech_porosity]
    order = FIRST
    family = MONOMIAL
  []
  [plastic_p]
    family = MONOMIAL
    order = CONSTANT
  []
  [stress_12]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[AuxKernels]
  inactive = 'eqv_plastic_strain'
  [stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  []
  [pe11]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe11
    index_i = 0
    index_j = 0
  []
  [pe22]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe22
    index_i = 1
    index_j = 1
  []
  [pe33]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe33
    index_i = 2
    index_j = 2
  []
  [eqv_plastic_strain]
    type = FiniteStrainPlasticAux
    variable = 'peeq'
  []
  [mises_stress]
    type = MaterialRealAux
    variable = mises_stress
    property = mises_stress
  []
  [mises_strain]
    type = MaterialRealAux
    variable = mises_strain
    property = mises_strain
  []
  [mises_strain_rate]
    type = MaterialRealAux
    variable = mises_strain_rate
    block = '0'
    property = mises_strain_rate
  []
  [Gruntfest_Number]
    type = MaterialRealAux
    variable = Mod_Gruntfest_number
    property = mod_gruntfest_number
    block = '0'
  []
  [mean_stress]
    type = MaterialRealAux
    variable = mean_stress
    property = mean_stress
    block = '0'
  []
  [volumetric_strain]
    type = MaterialRealAux
    variable = volumetric_strain
    property = volumetric_strain
  []
  [volumetric_strain_rate]
    type = MaterialRealAux
    variable = volumetric_strain_rate
    property = volumetric_strain_rate
  []
  [total_porosity]
    type = RedbackTotalPorosityAux
    variable = total_porosity
    mechanical_porosity = 'mech_porosity'
  []
  [mech_porosity]
    type = MaterialRealAux
    variable = mech_porosity
    execute_on = 'timestep_end'
    property = mechanical_porosity
  []
  [plastic_strain]
    type = MaterialRealAux
    variable = plastic_p
    property = eqv_plastic_strain
  []
  [stress_12]
    type = RankTwoAux
    variable = stress_12
    rank_two_tensor = stress
    index_j = 1
    index_i = 0
  []
[]

[Postprocessors]
  inactive = 'temp_middle'
  [mises_stress]
    type = PointValue
    variable = mises_stress
    point = '0 0 0'
  []
  [mises_strain]
    type = PointValue
    variable = mises_strain
    point = '0 0 0'
  []
  [mises_strain_rate]
    type = PointValue
    variable = mises_strain_rate
    point = '0 0 0'
  []
  [temp_middle]
    type = PointValue
    variable = temp
    point = '0 0 0'
  []
  [mean_stress]
    type = PointValue
    variable = mean_stress
    point = '0 0 0'
  []
  [volumetric_strain]
    type = PointValue
    variable = volumetric_strain
    point = '0 0 0'
  []
  [volumetric_strain_rate]
    type = PointValue
    variable = volumetric_strain_rate
    point = '0 0 0'
  []
  [disp_y_top]
    type = PointValue
    point = '60 60 60'
    variable = disp_y
  []
  [disp_x_top]
    type = PointValue
    point = '60 60 60'
    variable = disp_x
  []
  [number_nonlin]
    type = NumNonlinearIterations
  []
  [tangential_force]
    type = SideAverageValue
    variable = 'stress_12'
    boundary = 'top'
  []
  [dt]
    type = TimestepSize
  []
[]

[Preconditioning]
  # active = ''
  [SMP]
    type = SMP
    full = true
    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it -ksp_max_it -sub_pc_type -sub_pc_factor_shift_type'
    petsc_options_value = 'gmres asm 1E-6 1E-10 30 500 lu NONZERO'
  []
[]

[Executioner]
  # Preconditioned JFNK (default)
  # petsc_options_iname = '-pc_type -pc_hypre_type -snes_linesearch_type -ksp_gmres_restart'
  # petsc_options_value = 'hypre boomeramg cp 201'
  type = Transient
  start_time = 0.0
  dtmax = 10
  dtmin = 1e-7
  l_max_its = 200
  nl_max_its = 20
  solve_type = NEWTON
  nl_abs_tol = 1e-8 # 1e-10 to begin with
  reset_dt = true
  line_search = basic
  dt = 30
  [TimeStepper]
    type = ConstantDT
    dt = 1
  []
[]

[Outputs]
  # output_initial = true
  file_base = bench_DP_out2
  exodus = true
  print_linear_residuals = false
  [console]
    type = Console
    perf_log = true
  []
[]

[RedbackMechAction]
  [solid]
    disp_z = disp_z
    disp_y = disp_y
    disp_x = disp_x
  []
[]

[Bounds]
[]

[Problem]
  material_coverage_check = false
  kernel_coverage_check = false
[]

[MeshModifiers]
  [New_0]
    type = AssignElementSubdomainID
    element_ids = '5'
    subdomain_ids = '1'
  []
[]
