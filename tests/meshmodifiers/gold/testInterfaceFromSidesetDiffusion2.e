CDF      
   %   
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes      (   num_elem   (   
num_el_blk        num_node_sets         num_side_sets         num_el_in_blk1        num_nod_per_el1       num_el_in_blk2        num_nod_per_el2       num_el_in_blk3        num_nod_per_el3       num_el_in_blk4        num_nod_per_el4       num_side_ss1      num_side_ss2      num_side_ss3      num_side_ss4      num_side_ss5      num_side_ss6      num_side_ss7      num_side_ss8      num_nod_ns1       num_nod_ns2       num_nod_ns3       num_nod_ns4       num_nod_ns5       num_nod_ns6       num_nod_ns7       num_nod_ns8       num_nod_var       num_info   �         api_version       @�
=   version       @�
=   floating_point_word_size            	file_size               int64_status             title         %testInterfaceFromSidesetDiffusion2.e       maximum_name_length                 .   
time_whole                            f�   	eb_status                                 eb_prop1               name      ID                 	ns_status         	                         ns_prop1      	         name      ID               @   	ss_status         
                     `   ss_prop1      
         name      ID               �   coordx                     @      �   coordy                     @      �   eb_names                       �          ns_names      	                      �   ss_names      
                      �   
coor_names                         D      �   node_num_map                    �      �   connect1                  	elem_type         TRI3          �      �   connect2                  	elem_type         TRI3          0      X   connect3                  	elem_type         TRI3          �      �   connect4                  	elem_type         TRI3          0      H   elem_num_map                    �      x   elem_ss1                              side_ss1                           8   elem_ss2                          X   side_ss2                          h   elem_ss3                          x   side_ss3                          �   elem_ss4                           �   side_ss4                           �   elem_ss5                          �   side_ss5                          �   elem_ss6                          �   side_ss6                             elem_ss7                             side_ss7                          (   elem_ss8                          8   side_ss8                          D   node_ns1                          P   node_ns2                          h   node_ns3                    0      �   node_ns4                    0      �   node_ns5                          �   node_ns6                           �   node_ns7      !                       node_ns8      "                    (   vals_nod_var1                         @      f�   name_nod_var      #                 $      <   info_records      $                N(      `                                                                      	   
                                 
          	                      ?�������?ə���`C?�      ?�      ?�%v'��        ?�333333?ٙ����?�      ?�~ ���                ?�      ?������?����̼�?�      ?�      ?�    $?陙����?���5�2?�      ?�ffffff?�33332Y?�� ז�?�      ?�      ?�ffff�p?ٙ����?�      ?�333333?�33332Y?�ffffff?�      ?�      ?�      ?�      ?������?�      ?�    H�?�    IQ?��Q�o�?Ǯz�) ?�      ?�      ?�N�g7E                ?�������?�      ?�v�?�    <?�              ?�    9�        ?�������?�������?�p��
:�?�z�G��?��b�1�y?�      ?�      ?�������?Ŋ'��xd?������        ?�      ?�������?�              ?�������?�      ?�      ?�      ?�              ?�    9�?�      blockA                           blockB                           blockC                           blockD                                                                                                                                                                                                                                                                                                   ss3                              bottom                           left                             ss2                              interface_ss2                    right                            interface_ss3                    top                                                                                                                             	   
                                                                      !   "   #   $   %   &   '   (                                                                                                                                                                    
   	      
         
                     (   '         '                           (               '   &                        &                              '               !   "      $   !      $      %   #   !   $                           	   
                                                                      !   "   #   $   %   &   '   (      	               '   (                                                          
                                 "   %   (                                 %   (                        !                     '   (                  %   '                      !   "   #   #   $   %   &   '   (      	   
                   !   "   #   (                     #   $   %   &   '   (      	                &               "   %                              dymmy_var                           ####################                                                             # Created by MOOSE #                                                             ####################                                                             ### Command Line Arguments ###                                                    /Users/pou036/projects/redback/redback-opt -i testInterfaceFromSidesetDiffus... ion2.i --no-gdb-backtrace### Version Info ###                                                                                                                     Framework Information:                                                           MOOSE Version:           git commit f509b3ce9c on 2019-08-05                     LibMesh Version:         da98c0178b4d03f222d6b02c1a701eea8a38af5e                PETSc Version:           3.10.5                                                  Current Time:            Fri Aug  9 12:47:55 2019                                Executable Timestamp:    Fri Aug  9 12:44:42 2019                                                                                                                                                                                                  ### Input File ###                                                                                                                                                []                                                                                 inactive                       = (no_default)                                    initial_from_file_timestep     = LATEST                                          initial_from_file_var          = INVALID                                         element_order                  = AUTO                                            order                          = AUTO                                            side_order                     = AUTO                                            type                           = GAUSS                                         []                                                                                                                                                                [BCs]                                                                                                                                                               [./left]                                                                           boundary                     = left                                              control_tags                 = INVALID                                           displacements                = INVALID                                           enable                       = 1                                                 extra_matrix_tags            = INVALID                                           extra_vector_tags            = INVALID                                           implicit                     = 1                                                 inactive                     = (no_default)                                      isObjectAction               = 1                                                 matrix_tags                  = system                                            type                         = DirichletBC                                       use_displaced_mesh           = 0                                                 variable                     = dymmy_var                                         vector_tags                  = nontime                                           diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 value                        = 0                                               [../]                                                                                                                                                             [./right]                                                                          boundary                     = right                                             control_tags                 = INVALID                                           displacements                = INVALID                                           enable                       = 1                                                 extra_matrix_tags            = INVALID                                           extra_vector_tags            = INVALID                                           implicit                     = 1                                                 inactive                     = (no_default)                                      isObjectAction               = 1                                                 matrix_tags                  = system                                            type                         = DirichletBC                                       use_displaced_mesh           = 0                                                 variable                     = dymmy_var                                         vector_tags                  = nontime                                           diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 value                        = 1                                               [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      auto_preconditioning           = 1                                               inactive                       = (no_default)                                    isObjectAction                 = 1                                               type                           = Steady                                          accept_on_max_picard_iteration = 0                                               automatic_scaling              = INVALID                                         compute_initial_residual_before_preset_bcs = 0                                   compute_scaling_once           = 1                                               contact_line_search_allowed_lambda_cuts = 2                                      contact_line_search_ltol       = INVALID                                         control_tags                   = (no_default)                                    disable_picard_residual_norm_check = 0                                           enable                         = 1                                               l_abs_step_tol                 = -1                                              l_abs_tol                      = 1e-50                                           l_max_its                      = 10000                                           l_tol                          = 1e-05                                           line_search                    = default                                         line_search_package            = petsc                                           max_xfem_update                = 4294967295                                      mffd_type                      = wp                                              nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-50                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-08                                           petsc_options                  = INVALID                                         petsc_options_iname            = INVALID                                         petsc_options_value            = INVALID                                         picard_abs_tol                 = 1e-50                                           picard_force_norms             = 0                                               picard_max_its                 = 1                                               picard_rel_tol                 = 1e-08                                           relaxation_factor              = 1                                               relaxed_variables              = (no_default)                                    restart_file_base              = (no_default)                                    snesmf_reuse_base              = 1                                               solve_type                     = NEWTON                                          splitting                      = INVALID                                         time                           = 0                                               update_xfem_at_timestep_begin  = 0                                               verbose                        = 0                                             []                                                                                                                                                                [Kernels]                                                                                                                                                           [./diff]                                                                           inactive                     = (no_default)                                      isObjectAction               = 1                                                 type                         = Diffusion                                         block                        = INVALID                                           control_tags                 = Kernels                                           diag_save_in                 = INVALID                                           displacements                = INVALID                                           enable                       = 1                                                 extra_matrix_tags            = INVALID                                           extra_vector_tags            = INVALID                                           implicit                     = 1                                                 matrix_tags                  = system                                            save_in                      = INVALID                                           seed                         = 0                                                 use_displaced_mesh           = 0                                                 variable                     = dymmy_var                                         vector_tags                  = nontime                                         [../]                                                                          []                                                                                                                                                                [Mesh]                                                                             displacements                  = INVALID                                         inactive                       = (no_default)                                    use_displaced_mesh             = 1                                               include_local_in_ghosting      = 0                                               output_ghosting                = 0                                               block_id                       = INVALID                                         block_name                     = INVALID                                         boundary_id                    = INVALID                                         boundary_name                  = INVALID                                         construct_side_list_from_node_list = 0                                           ghosted_boundaries             = INVALID                                         ghosted_boundaries_inflation   = INVALID                                         isObjectAction                 = 1                                               second_order                   = 0                                               skip_partitioning              = 0                                               type                           = FileMesh                                        uniform_refine                 = 0                                               allow_renumbering              = 1                                               centroid_partitioner_direction = INVALID                                         construct_node_list_from_side_list = 1                                           control_tags                   = (no_default)                                    dim                            = 1                                               enable                         = 1                                               file                           = /Users/pou036/projects/redback/tests/meshm... odifiers/../../meshes/fractureX.msh                                                ghosting_patch_size            = INVALID                                         max_leaf_size                  = 10                                              nemesis                        = 0                                               parallel_type                  = DEFAULT                                         partitioner                    = default                                         patch_size                     = 40                                              patch_update_strategy          = never                                         []                                                                                                                                                                [Mesh]                                                                           []                                                                                                                                                                [Mesh]                                                                           []                                                                                                                                                                [MeshModifiers]                                                                                                                                                     [./break]                                                                          inactive                     = (no_default)                                      isObjectAction               = 1                                                 type                         = InterfaceFromSideset                              boundaries                   = 'top bottom left right'                           control_tags                 = MeshModifiers                                     depends_on                   = INVALID                                           enable                       = 1                                                 force_prepare                = 0                                                 interface_name               = interface                                         sidesets                     = 'ss2 ss3'                                         split_interface              = 0                                               [../]                                                                          []                                                                                                                                                                [Outputs]                                                                          append_date                    = 0                                               append_date_format             = INVALID                                         checkpoint                     = 0                                               color                          = 1                                               console                        = 1                                               controls                       = 0                                               csv                            = 0                                               dofmap                         = 0                                               execute_on                     = 'INITIAL TIMESTEP_END'                          exodus                         = 1                                               file_base                      = testInterfaceFromSidesetDiffusion2              gmv                            = 0                                               gnuplot                        = 0                                               hide                           = INVALID                                         inactive                       = (no_default)                                    interval                       = 1                                               nemesis                        = 0                                               output_if_base_contains        = INVALID                                         perf_graph                     = 0                                               print_linear_residuals         = 1                                               print_mesh_changed_info        = 0                                               print_perf_log                 = 0                                               show                           = INVALID                                         solution_history               = 0                                               sync_times                     = (no_default)                                    tecplot                        = 0                                               vtk                            = 0                                               xda                            = 0                                               xdr                            = 0                                             []                                                                                                                                                                [Variables]                                                                                                                                                         [./dymmy_var]                                                                      block                        = INVALID                                           components                   = 1                                                 eigen                        = 0                                                 family                       = LAGRANGE                                          inactive                     = (no_default)                                      initial_condition            = INVALID                                           order                        = FIRST                                             outputs                      = INVALID                                           scaling                      = INVALID                                           initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                         [../]                                                                          []                                                                                                                                                                                                                                                                                                                                                                                                                        ?�                                                                                                                                              ?�      ?�      ?�������?�     �?������
?�      ?�     �?�     )?�������?�      ?�                                                                              ?�������?�������?�     �