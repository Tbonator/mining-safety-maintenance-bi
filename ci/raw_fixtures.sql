-- Small, made-up rows in the same shape as the real MSHA raw tables.
-- Used by GitHub Actions to test the dbt project without downloading MSHA data.
-- Every column is text, exactly like the tables dlt creates.

create table raw.msha_accidents (
    mine_id text,
    controller_id text,
    controller_name text,
    operator_id text,
    operator_name text,
    contractor_id text,
    document_no text,
    subunit_cd text,
    subunit text,
    accident_dt text,
    cal_yr text,
    cal_qtr text,
    fiscal_yr text,
    fiscal_qtr text,
    accident_time text,
    degree_injury_cd text,
    degree_injury text,
    fips_state_cd text,
    ug_location_cd text,
    ug_location text,
    ug_mining_method_cd text,
    ug_mining_method text,
    mining_equip_cd text,
    mining_equip text,
    equip_mfr_cd text,
    equip_mfr_name text,
    equip_model_no text,
    shift_begin_time text,
    classification_cd text,
    classification text,
    accident_type_cd text,
    accident_type text,
    no_injuries text,
    tot_exper text,
    mine_exper text,
    job_exper text,
    occupation_cd text,
    occupation text,
    activity_cd text,
    activity text,
    injury_source_cd text,
    injury_source text,
    nature_injury_cd text,
    nature_injury text,
    inj_body_part_cd text,
    inj_body_part text,
    schedule_charge text,
    days_restrict text,
    days_lost text,
    trans_term text,
    return_to_work_dt text,
    immed_notify_cd text,
    immed_notify text,
    invest_begin_dt text,
    narrative text,
    closed_doc_no text,
    coal_metal_ind text,
    _source_file text
);
insert into raw.msha_accidents (mine_id, controller_id, controller_name, operator_id, operator_name, contractor_id, document_no, subunit_cd, subunit, accident_dt, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, accident_time, degree_injury_cd, degree_injury, fips_state_cd, ug_location_cd, ug_location, ug_mining_method_cd, ug_mining_method, mining_equip_cd, mining_equip, equip_mfr_cd, equip_mfr_name, equip_model_no, shift_begin_time, classification_cd, classification, accident_type_cd, accident_type, no_injuries, tot_exper, mine_exper, job_exper, occupation_cd, occupation, activity_cd, activity, injury_source_cd, injury_source, nature_injury_cd, nature_injury, inj_body_part_cd, inj_body_part, schedule_charge, days_restrict, days_lost, trans_term, return_to_work_dt, immed_notify_cd, immed_notify, invest_begin_dt, narrative, closed_doc_no, coal_metal_ind, _source_file)
values ('0100001', '', '', '', '', '', '220000001', '', '', '05/01/2023', '2023', '2', '', '', '', '', 'DAYS AWAY FROM WORK ONLY', '', '', '', '', '', '', 'Ore haulage trucks - off highway trucks', '', '', '', '', '', 'POWERED HAULAGE', '', 'Struck by falling object', '1', '', '0.5', '', '', '', '', '', '', '', '', '', '', '', '', '', '12', '', '', '', '', '', '', '', '', 'ci_fixture.txt');
insert into raw.msha_accidents (mine_id, controller_id, controller_name, operator_id, operator_name, contractor_id, document_no, subunit_cd, subunit, accident_dt, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, accident_time, degree_injury_cd, degree_injury, fips_state_cd, ug_location_cd, ug_location, ug_mining_method_cd, ug_mining_method, mining_equip_cd, mining_equip, equip_mfr_cd, equip_mfr_name, equip_model_no, shift_begin_time, classification_cd, classification, accident_type_cd, accident_type, no_injuries, tot_exper, mine_exper, job_exper, occupation_cd, occupation, activity_cd, activity, injury_source_cd, injury_source, nature_injury_cd, nature_injury, inj_body_part_cd, inj_body_part, schedule_charge, days_restrict, days_lost, trans_term, return_to_work_dt, immed_notify_cd, immed_notify, invest_begin_dt, narrative, closed_doc_no, coal_metal_ind, _source_file)
values ('0100001', '', '', '', '', '', '220000002', '', '', '08/20/2023', '2023', '3', '', '', '', '', 'NO DYS AWY FRM WRK,NO RSTR ACT', '', '', '', '', '', '', 'Hand tools (not powered)', '', '', '', '', '', '', '', '', '1', '', '12', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'ci_fixture.txt');
insert into raw.msha_accidents (mine_id, controller_id, controller_name, operator_id, operator_name, contractor_id, document_no, subunit_cd, subunit, accident_dt, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, accident_time, degree_injury_cd, degree_injury, fips_state_cd, ug_location_cd, ug_location, ug_mining_method_cd, ug_mining_method, mining_equip_cd, mining_equip, equip_mfr_cd, equip_mfr_name, equip_model_no, shift_begin_time, classification_cd, classification, accident_type_cd, accident_type, no_injuries, tot_exper, mine_exper, job_exper, occupation_cd, occupation, activity_cd, activity, injury_source_cd, injury_source, nature_injury_cd, nature_injury, inj_body_part_cd, inj_body_part, schedule_charge, days_restrict, days_lost, trans_term, return_to_work_dt, immed_notify_cd, immed_notify, invest_begin_dt, narrative, closed_doc_no, coal_metal_ind, _source_file)
values ('0100003', '', '', '', '', 'ABC', '220000003', '', '', '01/09/2024', '2024', '1', '', '', '', '', 'FATALITY', '', '', '', '', '', '', 'NO VALUE FOUND', '', '', '', '', '', '', '', '', '1', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '?', '', '', '', '', '', '', '', '', 'ci_fixture.txt');
insert into raw.msha_accidents (mine_id, controller_id, controller_name, operator_id, operator_name, contractor_id, document_no, subunit_cd, subunit, accident_dt, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, accident_time, degree_injury_cd, degree_injury, fips_state_cd, ug_location_cd, ug_location, ug_mining_method_cd, ug_mining_method, mining_equip_cd, mining_equip, equip_mfr_cd, equip_mfr_name, equip_model_no, shift_begin_time, classification_cd, classification, accident_type_cd, accident_type, no_injuries, tot_exper, mine_exper, job_exper, occupation_cd, occupation, activity_cd, activity, injury_source_cd, injury_source, nature_injury_cd, nature_injury, inj_body_part_cd, inj_body_part, schedule_charge, days_restrict, days_lost, trans_term, return_to_work_dt, immed_notify_cd, immed_notify, invest_begin_dt, narrative, closed_doc_no, coal_metal_ind, _source_file)
values ('0100003', '', '', '', '', '', '220000004', '', '', '02/14/2024', '2024', '1', '', '', '', '', 'ACCIDENT ONLY', '', '', '', '', '', '', 'Conveyor, Belt feeder, Stage loader, Hopper shaker, Belt structure', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'ci_fixture.txt');

create table raw.msha_employment_production_quarterly (
    mine_id text,
    curr_mine_nm text,
    state text,
    subunit_cd text,
    subunit text,
    cal_yr text,
    cal_qtr text,
    fiscal_yr text,
    fiscal_qtr text,
    avg_employee_cnt text,
    hours_worked text,
    coal_production text,
    coal_metal_ind text,
    _source_file text
);
insert into raw.msha_employment_production_quarterly (mine_id, curr_mine_nm, state, subunit_cd, subunit, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, avg_employee_cnt, hours_worked, coal_production, coal_metal_ind, _source_file)
values ('0100001', 'North Pit', '', '1', 'STRIP, QUARY, OPEN PIT', '2023', '2', '', '', '40', '20000', '15000', 'C', 'ci_fixture.txt');
insert into raw.msha_employment_production_quarterly (mine_id, curr_mine_nm, state, subunit_cd, subunit, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, avg_employee_cnt, hours_worked, coal_production, coal_metal_ind, _source_file)
values ('0100001', 'North Pit', '', '99', 'OFFICE WORKERS AT MINE SITE', '2023', '2', '', '', '2', '1000', '', 'C', 'ci_fixture.txt');
insert into raw.msha_employment_production_quarterly (mine_id, curr_mine_nm, state, subunit_cd, subunit, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, avg_employee_cnt, hours_worked, coal_production, coal_metal_ind, _source_file)
values ('0100001', 'North Pit', '', '1', 'STRIP, QUARY, OPEN PIT', '2023', '3', '', '', '41', '21000', '16000', 'C', 'ci_fixture.txt');
insert into raw.msha_employment_production_quarterly (mine_id, curr_mine_nm, state, subunit_cd, subunit, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, avg_employee_cnt, hours_worked, coal_production, coal_metal_ind, _source_file)
values ('0100003', 'Deep Mine', '', '3', 'UNDERGROUND', '2024', '1', '', '', '10', '5000', '', 'M', 'ci_fixture.txt');

create table raw.msha_mines (
    mine_id text,
    current_mine_name text,
    coal_metal_ind text,
    current_mine_type text,
    current_mine_status text,
    current_status_dt text,
    current_controller_id text,
    current_controller_name text,
    current_operator_id text,
    current_operator_name text,
    state text,
    bom_state_cd text,
    fips_cnty_cd text,
    fips_cnty_nm text,
    cong_dist_cd text,
    company_type text,
    current_controller_begin_dt text,
    district text,
    office_cd text,
    office_name text,
    assess_ctrl_no text,
    primary_sic_cd text,
    primary_sic text,
    primary_sic_cd_1 text,
    primary_sic_cd_sfx text,
    secondary_sic_cd text,
    secondary_sic text,
    secondary_sic_cd_1 text,
    secondary_sic_cd_sfx text,
    primary_canvass_cd text,
    primary_canvass text,
    secondary_canvass_cd text,
    secondary_canvass text,
    current_103_i text,
    current_103_i_dt text,
    portable_operation text,
    portable_fips_st_cd text,
    days_per_week text,
    hours_per_shift text,
    prod_shifts_per_day text,
    maint_shifts_per_day text,
    no_employees text,
    part48_training text,
    longitude text,
    latitude text,
    avg_mine_height text,
    mine_gas_category_cd text,
    methane_liberation text,
    no_producing_pits text,
    no_nonproducing_pits text,
    no_tailing_ponds text,
    pillar_recovery_used text,
    highwall_miner_used text,
    multiple_pits text,
    miners_rep_ind text,
    safety_committee_ind text,
    miles_from_office text,
    directions_to_mine text,
    nearest_town text,
    _source_file text
);
insert into raw.msha_mines (mine_id, current_mine_name, coal_metal_ind, current_mine_type, current_mine_status, current_status_dt, current_controller_id, current_controller_name, current_operator_id, current_operator_name, state, bom_state_cd, fips_cnty_cd, fips_cnty_nm, cong_dist_cd, company_type, current_controller_begin_dt, district, office_cd, office_name, assess_ctrl_no, primary_sic_cd, primary_sic, primary_sic_cd_1, primary_sic_cd_sfx, secondary_sic_cd, secondary_sic, secondary_sic_cd_1, secondary_sic_cd_sfx, primary_canvass_cd, primary_canvass, secondary_canvass_cd, secondary_canvass, current_103_i, current_103_i_dt, portable_operation, portable_fips_st_cd, days_per_week, hours_per_shift, prod_shifts_per_day, maint_shifts_per_day, no_employees, part48_training, longitude, latitude, avg_mine_height, mine_gas_category_cd, methane_liberation, no_producing_pits, no_nonproducing_pits, no_tailing_ponds, pillar_recovery_used, highwall_miner_used, multiple_pits, miners_rep_ind, safety_committee_ind, miles_from_office, directions_to_mine, nearest_town, _source_file)
values ('0100001', 'North Pit', 'C', 'Surface', 'Active', '03/15/2019', '', '', '', 'Example Coal LLC', 'WV', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'N', '', '', '', '', '', '42', '', '-81.2', '37.5', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'ci_fixture.txt');
insert into raw.msha_mines (mine_id, current_mine_name, coal_metal_ind, current_mine_type, current_mine_status, current_status_dt, current_controller_id, current_controller_name, current_operator_id, current_operator_name, state, bom_state_cd, fips_cnty_cd, fips_cnty_nm, cong_dist_cd, company_type, current_controller_begin_dt, district, office_cd, office_name, assess_ctrl_no, primary_sic_cd, primary_sic, primary_sic_cd_1, primary_sic_cd_sfx, secondary_sic_cd, secondary_sic, secondary_sic_cd_1, secondary_sic_cd_sfx, primary_canvass_cd, primary_canvass, secondary_canvass_cd, secondary_canvass, current_103_i, current_103_i_dt, portable_operation, portable_fips_st_cd, days_per_week, hours_per_shift, prod_shifts_per_day, maint_shifts_per_day, no_employees, part48_training, longitude, latitude, avg_mine_height, mine_gas_category_cd, methane_liberation, no_producing_pits, no_nonproducing_pits, no_tailing_ponds, pillar_recovery_used, highwall_miner_used, multiple_pits, miners_rep_ind, safety_committee_ind, miles_from_office, directions_to_mine, nearest_town, _source_file)
values ('0100002', 'Old Quarry', 'M', 'Surface', 'Abandoned', '', '', '', '', '', 'KY', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'N', '', '', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'ci_fixture.txt');
insert into raw.msha_mines (mine_id, current_mine_name, coal_metal_ind, current_mine_type, current_mine_status, current_status_dt, current_controller_id, current_controller_name, current_operator_id, current_operator_name, state, bom_state_cd, fips_cnty_cd, fips_cnty_nm, cong_dist_cd, company_type, current_controller_begin_dt, district, office_cd, office_name, assess_ctrl_no, primary_sic_cd, primary_sic, primary_sic_cd_1, primary_sic_cd_sfx, secondary_sic_cd, secondary_sic, secondary_sic_cd_1, secondary_sic_cd_sfx, primary_canvass_cd, primary_canvass, secondary_canvass_cd, secondary_canvass, current_103_i, current_103_i_dt, portable_operation, portable_fips_st_cd, days_per_week, hours_per_shift, prod_shifts_per_day, maint_shifts_per_day, no_employees, part48_training, longitude, latitude, avg_mine_height, mine_gas_category_cd, methane_liberation, no_producing_pits, no_nonproducing_pits, no_tailing_ponds, pillar_recovery_used, highwall_miner_used, multiple_pits, miners_rep_ind, safety_committee_ind, miles_from_office, directions_to_mine, nearest_town, _source_file)
values ('0100003', 'Deep Mine', 'M', 'Underground', 'Active', '', '', '', '', '', 'NV', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Y', '', '', '', '', '', '?', '', '-116.5', '90.999722', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'ci_fixture.txt');

create table raw.msha_contractor_employment_production_quarterly (
    contractor_id text,
    contractor_name text,
    cal_yr text,
    cal_qtr text,
    fiscal_yr text,
    fiscal_qtr text,
    subunit_cd text,
    subunit text,
    avg_employee_cnt text,
    hours_worked text,
    coal_production text,
    coal_metal_ind text,
    _source_file text
);
insert into raw.msha_contractor_employment_production_quarterly (contractor_id, contractor_name, cal_yr, cal_qtr, fiscal_yr, fiscal_qtr, subunit_cd, subunit, avg_employee_cnt, hours_worked, coal_production, coal_metal_ind, _source_file)
values ('ABC', 'Abc Contracting', '2024', '1', '', '', '3', 'UNDERGROUND', '3', '1500', '', 'M', 'ci_fixture.txt');