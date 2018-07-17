[Mesh]
  type = GeneratedMesh
  uniform_refine = 0
  dim = 2
  nx = 4
  ny = 4
[]

[MeshModifiers]
  [subdomain]
    type = SubdomainBoundingBox
    bottom_left = '0 0.5 0'
    block_id = 1
    top_right = '1 1 0'
  []
  [left_break]
    type = BreakBoundaryOnSubdomain
    depends_on = 'subdomain'
    boundaries = 'left'
  []
  [right_break]
    type = BreakBoundaryOnSubdomain
    depends_on = 'subdomain'
    boundaries = 'right'
  []
  [interface_bottom]
    type = SideSetsBetweenSubdomains
    master_block = '0'
    depends_on = 'subdomain'
    new_boundary = 'interface_bottom'
    paired_block = '1'
  []
  [interface_top]
    type = SideSetsBetweenSubdomains
    master_block = '1'
    depends_on = 'subdomain'
    new_boundary = 'interface_top'
    paired_block = '0'
  []
[]

[Variables]
  [disp0_x]
    block = '0'
  []
  [disp1_x]
    block = '1'
  []
  [disp0_y]
    block = '0'
  []
  [disp1_y]
    block = '1'
  []
  [porepressure]
  []
[]

[AuxVariables]
  [stress0_yy]
    block = '0'
    family = MONOMIAL
    order = CONSTANT
  []
  [stress1_yy]
    block = '1'
    family = MONOMIAL
    order = CONSTANT
  []
[]

[AuxKernels]
  [stress0_yy]
    type = RankTwoAux
    rank_two_tensor = 0_stress
    index_j = 1
    index_i = 1
    variable = stress0_yy
  []
  [stress1_yy]
    type = RankTwoAux
    rank_two_tensor = 1_stress
    index_j = 1
    index_i = 1
    variable = stress1_yy
  []
[]

[InterfaceKernels]
  [interface_x]
    type = InterfaceStress
    variable = disp0_x
    neighbor_var = 'disp1_x'
    boundary = 'interface_bottom'
    component = 0
    base_name_master = 0
    base_name_slave = 1
    other_disp_master = 'disp0_y'
    other_disp_slave = 'disp1_y'
    pressure_master = 'porepressure'
    pressure_slave = 'porepressure'
  []
  [interface_y]
    type = InterfaceStress
    variable = disp0_y
    neighbor_var = 'disp1_y'
    boundary = 'interface_bottom'
    component = 1
    base_name_master = 0
    base_name_slave = 1
    other_disp_master = 'disp0_x'
    other_disp_slave = 'disp1_x'
    pressure_master = 'porepressure'
    pressure_slave = 'porepressure'
  []
[]

[Kernels]
  [disp0_x]
    type = StressDivergenceTensors
    component = 0
    variable = disp0_x
    displacements = 'disp0_x disp0_y'
    block = '0'
    base_name = 0
  []
  [disp0_y]
    type = StressDivergenceTensors
    component = 1
    variable = disp0_y
    displacements = 'disp0_x disp0_y'
    block = '0'
    base_name = 0
  []
  [disp1_x]
    type = StressDivergenceTensors
    component = 0
    variable = disp1_x
    displacements = 'disp1_x disp1_y'
    block = '1'
    base_name = 1
  []
  [disp1_y]
    type = StressDivergenceTensors
    component = 1
    variable = disp1_y
    displacements = 'disp1_x disp1_y'
    block = '1'
    base_name = 1
  []
  [diff_pressure]
    type = Diffusion
    variable = porepressure
  []
  [poromech_x0]
    type = PoroMechanicsCoupling
    component = 0
    porepressure = 'porepressure'
    variable = disp0_x
  []
  [poromech_y0]
    type = PoroMechanicsCoupling
    component = 1
    porepressure = 'porepressure'
    variable = disp0_y
  []
  [poromech_x1]
    type = PoroMechanicsCoupling
    component = 0
    porepressure = 'porepressure'
    variable = disp1_x
  []
  [poromech_y1]
    type = PoroMechanicsCoupling
    component = 1
    porepressure = 'porepressure'
    variable = disp1_y
  []
[]

[Materials]
  [Elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 10000
    block = '0'
    base_name = 0
  []
  [Elasticity_tensor1]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 10000
    block = '1'
    base_name = 1
  []
  [mc]
    type = ComputeMultiPlasticityStress
    ep_plastic_tolerance = 1E-9
    plastic_models = 'j2'
    block = '0'
    base_name = 0
  []
  [mc1]
    type = ComputeMultiPlasticityStress
    ep_plastic_tolerance = 1E-9
    plastic_models = 'j2'
    block = '1'
    base_name = 1
  []
  [finite_strain0]
    type = ComputePlaneFiniteStrain
    block = '0'
    displacements = 'disp0_x disp0_y'
    base_name = 0
  []
  [finite_strain1]
    type = ComputePlaneFiniteStrain
    displacements = 'disp1_x disp1_y'
    block = '1'
    base_name = 1
  []
  [biot_coeff]
    type = GenericConstantMaterial
    prop_values = '1'
    prop_names = 'biot_coefficient'
  []
[]

[UserObjects]
  [str]
    type = TensorMechanicsHardeningConstant
    value = 1
  []
  [j2]
    type = TensorMechanicsPlasticJ2
    yield_strength = str
    yield_function_tolerance = 1E-9
    internal_constraint_tolerance = 1E-9
  []
[]

[Functions]
  [loading_vel]
    type = ParsedFunction
    value = '0.0002*t'
  []
[]

[BCs]
  [uy_top]
    type = FunctionPresetBC
    variable = disp1_y
    boundary = 'top'
    function = loading_vel
  []
  [no_disp0_x]
    type = PresetBC
    variable = disp0_x
    boundary = 'left_to_0'
    value = 0.0
  []
  [no_disp1_x]
    type = PresetBC
    variable = disp1_x
    boundary = 'left_to_1'
    value = 0.0
  []
  [no_disp_y]
    type = PresetBC
    variable = disp0_y
    boundary = 'bottom'
    value = 0.0
  []
  [pp_bottom]
    type = DirichletBC
    variable = porepressure
    boundary = 'bottom'
    value = 0.1
  []
  [matchx]
    type = MatchedValueJumpBC
    variable = disp0_x
    boundary = 'interface_bottom'
    v = 'disp1_x'
    tangent_jump = 0
    component = 0
  []
  [matchy]
    type = MatchedValueJumpBC
    variable = disp0_y
    boundary = 'interface_bottom'
    v = 'disp1_y'
    tangent_jump = 0
    component = 1
  []
[]

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  dt = 1
  l_max_its = 50
  nl_max_its = 10
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type -snes_linesearch_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg cp 201'
  nl_abs_tol = 1e-5
  nl_rel_tol = 1e-5
  reset_dt = true
  line_search = basic
  start_time = 0.0
  end_time = 2
[]

[Outputs]
  exodus = true
  file_base = compression_interface_pressure
[]